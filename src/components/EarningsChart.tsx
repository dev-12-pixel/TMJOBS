'use client';
import { formatCurrency } from '../lib/utils';

interface EarningsChartProps {
  data: { label: string; amount: number }[];
  title?: string;
}

export function EarningsChart({ data, title = 'Earnings Breakdown' }: EarningsChartProps) {
  const maxAmount = Math.max(...data.map(d => d.amount), 1);

  return (
    <div>
      <h4 className="text-sm font-semibold text-gray-700 mb-4">{title}</h4>
      <div className="space-y-3">
        {data.map((item, i) => (
          <div key={i}>
            <div className="flex justify-between text-sm mb-1">
              <span className="text-gray-600">{item.label}</span>
              <span className="font-bold text-gray-800">{formatCurrency(item.amount)}</span>
            </div>
            <div className="w-full bg-gray-100 rounded-full h-2">
              <div
                className="bg-green-500 h-2 rounded-full transition-all duration-500"
                style={{ width: `${(item.amount / maxAmount) * 100}%` }}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
