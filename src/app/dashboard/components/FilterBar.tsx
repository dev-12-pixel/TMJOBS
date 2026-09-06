'use client';
import { Calendar } from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Select } from '@/components/ui/Select';

interface FilterBarProps {
  dateRange: { start: string; end: string } | null;
  onDateRangeChange: (range: { start: string; end: string } | null) => void;
  statusFilter: string | null;
  onStatusFilterChange: (status: string | null) => void;
  clientFilter: string;
  onClientFilterChange: (client: string) => void;
  profileFilter: string;
  onProfileFilterChange: (profile: string) => void;
}

export function FilterBar({
  dateRange,
  onDateRangeChange,
  statusFilter,
  onStatusFilterChange,
  clientFilter,
  onClientFilterChange,
  profileFilter,
  onProfileFilterChange,
}: FilterBarProps) {
  return (
    <div className="flex flex-wrap items-center gap-4 p-4 bg-white rounded-xl border border-gray-200 mb-6">
      <div className="flex items-center gap-2 text-sm text-gray-600">
        <Calendar className="w-4 h-4" />
        <span>Filters:</span>
      </div>

      <div className="flex items-center gap-2">
        <label className="text-sm text-gray-600">Date Range:</label>
        <Input
          type="date"
          value={dateRange?.start || ''}
          onChange={(e) => {
            const start = e.target.value;
            if (start) {
              onDateRangeChange({ start, end: dateRange?.end || start });
            } else {
              onDateRangeChange(null);
            }
          }}
          className="w-40"
        />
        <span className="text-gray-400">to</span>
        <Input
          type="date"
          value={dateRange?.end || ''}
          onChange={(e) => {
            const end = e.target.value;
            if (dateRange) {
              onDateRangeChange({ ...dateRange, end });
            }
          }}
          className="w-40"
        />
      </div>

      <Select
        value={statusFilter || ''}
        onChange={(e) => onStatusFilterChange(e.target.value || null)}
        className="w-40"
      >
        <option value="">All Status</option>
        <option value="applied">Applied</option>
        <option value="signed_up">Signed Up</option>
        <option value="hired">Hired</option>
        <option value="not_hired">Not Hired</option>
        <option value="emailed">Emailed</option>
      </Select>

      <Select
        value={clientFilter}
        onChange={(e) => onClientFilterChange(e.target.value)}
        className="w-40"
      >
        <option value="all">All Clients</option>
        <option value="major-turing">Major Turing</option>
        <option value="micro1">Micro1</option>
      </Select>

      <Select
        value={profileFilter}
        onChange={(e) => onProfileFilterChange(e.target.value)}
        className="w-40"
      >
        <option value="all">All Profiles</option>
      </Select>

      <Button
        variant="ghost"
        onClick={() => {
          onDateRangeChange(null);
          onStatusFilterChange(null);
          onClientFilterChange('all');
          onProfileFilterChange('all');
        }}
      >
        Clear Filters
      </Button>
    </div>
  );
}
