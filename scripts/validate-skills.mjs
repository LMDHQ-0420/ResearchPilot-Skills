import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';

const root=fs.realpathSync(path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..'));
const errors=[];
let skills=0,refs=0;
function walk(dir){return fs.readdirSync(dir,{withFileTypes:true}).flatMap(d=>d.isDirectory()?walk(path.join(dir,d.name)):[path.join(dir,d.name)]);}
function fail(file,message){errors.push(`${path.relative(root,file)}: ${message}`);}
for(const lang of ['zh','en']){
 const base=path.join(root,'skills',`ResearchPilot-Skills-${lang}`);
 const dirs=fs.readdirSync(base,{withFileTypes:true}).filter(d=>d.isDirectory());
 if(dirs.length!==(lang==='zh'?17:16))fail(base,'Unexpected skill count');
 for(const dir of dirs){
  const folder=path.join(base,dir.name),entry=path.join(folder,'SKILL.md');
  if(!fs.existsSync(entry)){fail(folder,'Missing SKILL.md');continue;}
  skills++;
  const text=fs.readFileSync(entry,'utf8').replaceAll('\r\n','\n');
  const front=/^---\n([\s\S]*?)\n---(?:\n|$)/.exec(text)?.[1];
  if(!front){fail(entry,'Missing frontmatter');continue;}
  if(!front.split('\n').includes(`name: ${dir.name}`))fail(entry,'Frontmatter name differs from installed directory');
  const description=/^description:\s*>\n((?:[ \t]+[^\n]+\n?)+)/m.exec(front)?.[1];
  if(!description?.trim())fail(entry,'Missing folded description');
  if(dir.name!=='research[fig]'&&!text.includes('references/workflow-contract.md'))fail(entry,'Missing execution contract link');
  for(const file of walk(folder).filter(f=>f.endsWith('.md'))){
   const content=fs.readFileSync(file,'utf8');
   // Markdown links resolve relative to their own file; backticked references/ paths
   // in the existing corpus resolve relative to the skill root.
   const candidates=[...content.matchAll(/\]\((references\/[^)\n]+)\)/g)].map(m=>({ref:m[1],from:path.dirname(file)}));
   candidates.push(...[...content.matchAll(/`(references\/[^`\n]+)`/g)].map(m=>({ref:m[1],from:folder})));
   for(const {ref,from} of candidates){
    if(/[{}<>|*]/.test(ref))continue;
    const target=path.resolve(from,ref.split('#')[0]);
    const relative=path.relative(folder,target);
    refs++;
    if(relative==='..'||relative.startsWith(`..${path.sep}`)||path.isAbsolute(relative))fail(file,`Reference escapes independent skill: ${ref}`);
    else if(!fs.existsSync(target))fail(file,`Missing reference: ${ref}`);
    else if(ref.includes('#')){
      const anchor=ref.slice(ref.indexOf('#')+1);
      const headings=[...fs.readFileSync(target,'utf8').matchAll(/^#{1,6}\s+(.+)$/gm)]
        .map(m=>m[1].trim().toLowerCase().replace(/[^\p{L}\p{N}\s_-]/gu,'').replace(/\s/g,'-'));
      if(!headings.includes(anchor))fail(file,`Missing heading anchor: ${ref}`);
    }
   }
  }
 }
}
const shared=spawnSync(process.execPath,[path.join(root,'scripts','sync-shared-references.mjs'),'--check'],{encoding:'utf8'});
if(shared.status!==0)errors.push(shared.stderr||shared.error?.message||'Shared-reference check failed');
if(errors.length){console.error(errors.join('\n'));process.exitCode=1;}
else console.log(`Validated ${skills} skills, ${refs} local references, and shared-reference parity. No writes performed.`);
