import { SelectHTMLAttributes } from 'react';
import { cn } from '@/lib/utils';

export function Select({
  className,
  ...props
}: SelectHTMLAttributes<HTMLSelectElement>) {
  return (
    <select
      className={cn(
        'px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-sm bg-white',
        className
      )}
      {...props}
    />
  );
}
