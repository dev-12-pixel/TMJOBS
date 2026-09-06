import { ReactNode } from 'react';
import { cn } from '../lib/utils';

interface MetricCardProps {
  icon: ReactNode;
  label: string;
  value: number | string;
  subtitle?: string;
  trend?: 'up' | 'down';
  trendValue?: string;
}

export function MetricCard({
  icon,
  label,
  value,
  subtitle,
  trend,
  trendValue,
}: MetricCardProps) {
  return (
    <div className="metric-card animate-slide-up">
      <div className="flex items-center justify-between">
        <div className="p-3 bg-primary-50 rounded-lg">
          {icon}
        </div>
        {trend && (
          <span className={cn(
            'text-xs font-medium',
            trend === 'up' ? 'text-green-600' : 'text-red-600'
          )}>
            {trend === 'up' ? '↑' : '↓'} {trendValue}
          </span>
        )}
      </div>
      <div className="mt-4">
        <p className="text-2xl font-bold text-gray-800">{value}</p>
        <p className="text-sm text-gray-500 mt-1">{label}</p>
        {subtitle && <p className="text-xs text-gray-400 mt-1">{subtitle}</p>}
      </div>
    </div>
  );
}
