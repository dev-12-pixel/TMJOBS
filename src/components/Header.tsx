'use client';
import { Session } from '@supabase/supabase-js';
import { Button } from './ui/Button';
import { LogOut, User } from 'lucide-react';

interface HeaderProps {
  session: Session;
  onSignOut: () => void;
}

export function Header({ session, onSignOut }: HeaderProps) {
  return (
    <header className="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-40">
      <div className="flex items-center justify-between px-6 py-4">
        <div>
          <h1 className="text-xl font-bold text-gray-800">Dashboard</h1>
        </div>
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2 text-sm text-gray-600">
            <User className="w-4 h-4" />
            <span>{session.user.email}</span>
          </div>
          <Button variant="ghost" onClick={onSignOut} className="flex items-center gap-2">
            <LogOut className="w-4 h-4" />
            Sign Out
          </Button>
        </div>
      </div>
    </header>
  );
}
