'use client';
import { usePathname } from 'next/navigation';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import {
  LayoutDashboard,
  Users,
  UserSquare2,
  Briefcase,
  Building2,
  DollarSign,
  X,
} from 'lucide-react';
import { cn } from '../lib/utils';
import { supabase } from '../lib/supabase';
import type { Platform } from '../lib/types';

const staticItems = [
  { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { href: '/candidates', label: 'Candidates', icon: Users },
  { href: '/referrals', label: 'Referrals', icon: Briefcase },
  { href: '/accounts', label: 'Referral Accounts', icon: UserSquare2 },
  { href: '/jobs', label: 'Jobs', icon: Briefcase },
  { href: '/platforms', label: 'Platforms', icon: Building2 },
  { href: '/bonuses', label: 'Bonuses', icon: DollarSign },
];

interface SidebarProps {
  open: boolean;
  onClose: () => void;
}

export function Sidebar({ open, onClose }: SidebarProps) {
  const pathname = usePathname();
  const [platforms, setPlatforms] = useState<Platform[]>([]);

  useEffect(() => {
    supabase
      .from('platforms')
      .select('*')
      .eq('active', true)
      .order('name')
      .then(({ data }) => setPlatforms(data || []));
  }, []);

  return (
    <>
      {open && (
        <div
          className="fixed inset-0 bg-black/50 z-40 lg:hidden"
          onClick={onClose}
          aria-hidden="true"
        />
      )}

      <aside
        className={cn(
          'fixed left-0 top-0 h-full w-64 bg-gray-900 text-white z-50 overflow-y-auto transition-transform duration-200 ease-in-out',
          open ? 'translate-x-0' : '-translate-x-full',
          'lg:translate-x-0'
        )}
      >
        <div className="p-6 border-b border-gray-800 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-white rounded-lg flex items-center justify-center shrink-0">
              <span className="font-bold text-primary-700 text-xl">T</span>
            </div>
            <span className="text-xl font-bold">TMJOBS</span>
          </div>
          <button onClick={onClose} className="lg:hidden text-gray-400 hover:text-white p-1" aria-label="Close menu">
            <X className="w-5 h-5" />
          </button>
        </div>

        <nav className="p-4 space-y-1">
          {staticItems.map((item) => {
            const isActive = pathname === item.href || pathname.startsWith(item.href + '/');
            return (
              <Link
                key={item.href}
                href={item.href}
                onClick={onClose}
                className={cn(
                  'flex items-center gap-3 px-4 py-3 rounded-lg transition-colors',
                  isActive ? 'bg-primary-600 text-white' : 'text-gray-300 hover:bg-gray-800 hover:text-white'
                )}
              >
                <item.icon className="w-5 h-5" />
                {item.label}
              </Link>
            );
          })}

          {platforms.length > 0 && (
            <div className="pt-4 mt-4 border-t border-gray-800">
              <p className="px-4 pb-2 text-xs font-semibold uppercase tracking-wide text-gray-500">Platforms</p>
              {platforms.map((platform) => {
                const href = `/dashboard/platform/${platform.slug}`;
                const isActive = pathname === href;
                return (
                  <Link
                    key={platform.id}
                    href={href}
                    onClick={onClose}
                    className={cn(
                      'flex items-center gap-3 px-4 py-2.5 rounded-lg text-sm transition-colors',
                      isActive ? 'bg-primary-600 text-white' : 'text-gray-300 hover:bg-gray-800 hover:text-white'
                    )}
                  >
                    <Briefcase className="w-4 h-4" />
                    {platform.name}
                  </Link>
                );
              })}
            </div>
          )}
        </nav>
      </aside>
    </>
  );
}
