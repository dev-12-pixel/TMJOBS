const fs = require('fs');
const path = require('path');

const files = [
  'src/components/EarningsChart.tsx',
  'src/components/DashboardOverview.tsx',
  'src/components/MetricCard.tsx',
  'src/components/FilterBar.tsx',
];

files.forEach(file => {
  const fp = path.join(__dirname, file);
  let content = fs.readFileSync(fp, 'utf8');
  // Fix @/lib/utils → ../lib/utils
  content = content.replace(/'@\/lib\//g, "'../lib/");
  // Fix @/components/FilterBar → ./FilterBar (same directory)
  content = content.replace(/'@\/components\//g, "'./");
  // Fix @/hooks/useAuth → ../hooks/useAuth
  content = content.replace(/'@\/hooks\//g, "'../hooks/");
  fs.writeFileSync(fp, content);
  console.log('Fixed:', file);
});
