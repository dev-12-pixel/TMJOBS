const fs = require('fs');
const path = require('path');

function getRelativeImport(fromFile) {
  const fromDir = path.dirname(fromFile);
  const srcDir = path.join(__dirname, 'src');
  const relative = path.relative(fromDir, srcDir);
  return (relative || '.').replace(/\\/g, '/');
}

function fix(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(f => {
    const fp = path.join(dir, f);
    const stat = fs.statSync(fp);
    if (stat.isDirectory()) {
      fix(fp);
    } else if (f.endsWith('.tsx') || f.endsWith('.ts')) {
      let content = fs.readFileSync(fp, 'utf8');
      const relativePath = getRelativeImport(fp);
      content = content.replace(/@\//g, relativePath + '/');
      fs.writeFileSync(fp, content);
      console.log('Fixed:', fp, '->', relativePath);
    }
  });
}
fix(path.join(__dirname, 'src'));
console.log('Done!');
