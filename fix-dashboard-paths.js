const fs = require('fs');
const path = require('path');

function fixDir(dir) {
  const entries = fs.readdirSync(dir);
  entries.forEach(entry => {
    const fp = path.join(dir, entry);
    const stat = fs.statSync(fp);
    if (stat.isDirectory()) {
      fixDir(fp);
    } else if (entry.endsWith('.tsx') || entry.endsWith('.ts')) {
      let content = fs.readFileSync(fp, 'utf8');
      // Fix @/components/ → ../../../components/
      content = content.replace(/'@\/components\//g, "'../../../components/");
      // Fix @/lib/ → ../../../lib/
      content = content.replace(/'@\/lib\//g, "'../../../lib/");
      // Fix @/hooks/ → ../../hooks/
      content = content.replace(/'@\/hooks\//g, "'../../hooks/");
      fs.writeFileSync(fp, content);
      console.log('Fixed:', fp);
    }
  });
}

fixDir(path.join(__dirname, 'src/app/dashboard'));
console.log('Done!');
