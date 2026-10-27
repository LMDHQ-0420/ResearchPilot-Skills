import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fs.realpathSync(path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..'));
const check = process.argv.includes('--check');
let stale = 0;

function safe(target) {
  const absolute = path.resolve(target);
  let ancestor = absolute;
  while (!fs.existsSync(ancestor)) ancestor = path.dirname(ancestor);
  const real = fs.realpathSync(ancestor);
  const relative = path.relative(root, real);
  if (relative === '..' || relative.startsWith(`..${path.sep}`) || path.isAbsolute(relative)) {
    throw new Error(`Path outside repository: ${target}`);
  }
  return absolute;
}

for (const lang of ['zh', 'en']) {
  const base = path.join(root, 'skills', `ResearchPilot-Skills-${lang}`);
  for (const dir of fs.readdirSync(base, { withFileTypes: true })) {
    if (!dir.isDirectory() || dir.name === 'research[fig]') continue;
    for (const name of ['workflow-contract.md', 'template-flexibility.md']) {
      const source = path.join(root, 'shared', lang, name);
      const target = safe(path.join(base, dir.name, 'references', name));
      // The router does not use document templates.
      if (name === 'template-flexibility.md' && dir.name === 'research[START]') continue;
      const content = fs.readFileSync(source, 'utf8');
      if (fs.existsSync(target) && fs.readFileSync(target, 'utf8') === content) continue;
      stale++;
      if (check) console.error(`Out of sync: ${path.relative(root, target)}`);
      else {
        fs.mkdirSync(safe(path.dirname(target)), { recursive: true });
        fs.writeFileSync(target, content);
      }
    }
  }
}
console.log(check ? `${stale} shared references out of sync` : `${stale} shared references synchronized`);
if (check && stale) process.exitCode = 1;
