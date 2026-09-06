'use client';
import { Referral } from '@/lib/types';
import { Badge } from '@/components/ui/Badge';
import { format } from 'date-fns';
import { ArrowUpDown } from 'lucide-react';

interface ReferralTableProps {
  referrals: Referral[];
  title?: string;
  showActions?: boolean;
}

export function ReferralTable({ referrals, title = 'Referrals', showActions = true }: ReferralTableProps) {
  const statusColors = {
    applied: 'badge-info',
    signed_up: 'badge-warning',
    hired: 'badge-success',
    not_hired: 'badge-danger',
    emailed: 'badge-info',
  };

  return (
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead>
          <tr className="border-b border-gray-200">
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">
              <div className="flex items-center gap-1">
                Candidate <ArrowUpDown className="w-3 h-3" />
              </div>
            </th>
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Profile</th>
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Applied</th>
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Hired By</th>
            <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Bonus</th>
            {showActions && <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>}
          </tr>
        </thead>
        <tbody>
          {referrals.map((referral) => (
            <tr key={referral.id} className="border-b border-gray-100 hover:bg-gray-50">
              <td className="py-3 px-4">
                <div>
                  <p className="font-medium text-gray-800">
                    {referral.candidate_id}
                  </p>
                  <p className="text-sm text-gray-500">{referral.notes || 'No notes'}</p>
                </div>
              </td>
              <td className="py-3 px-4 text-sm text-gray-600">{referral.job_profile_id}</td>
              <td className="py-3 px-4">
                <Badge className={statusColors[referral.status as keyof typeof statusColors] || 'badge-info'}>
                  {referral.status.replace('_', ' ')}
                </Badge>
              </td>
              <td className="py-3 px-4 text-sm text-gray-600">
                {format(new Date(referral.applied_at), 'MMM dd, yyyy')}
              </td>
              <td className="py-3 px-4 text-sm text-gray-600">
                {referral.hired_by || '-'}
              </td>
              <td className="py-3 px-4 text-sm font-medium text-gray-800">
                ${referral.job_profile_id}
              </td>
              {showActions && (
                <td className="py-3 px-4">
                  <button className="text-primary-600 hover:text-primary-700 text-sm font-medium">
                    View
                  </button>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
      {referrals.length === 0 && (
        <div className="text-center py-8 text-gray-500">
          No referrals found
        </div>
      )}
    </div>
  );
}
