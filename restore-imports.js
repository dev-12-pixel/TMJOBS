const fs = require('fs');
const path = require('path');

function fix(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(f => {
    const fp = path.join(dir, f);
    const stat = fs.statSync(fp);
    if (stat.isDirectory()) {
      fix(fp);
    } else if (f.endsWith('.tsx') || f.endsWith('.ts')) {
      let content = fs.readFileSync(fp, 'utf8');
      // Restore @/ imports
      content = content.replace(/@([^/])/g, '@/$1');
      fs.writeFileSync(fp, content);
      console.log('Fixed:', fp);
    }
  });
}
fix(path.join(__dirname, 'src'));
console.log('Done!');
