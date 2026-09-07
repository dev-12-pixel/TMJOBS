'use client';
import { Session } from '@supabase/supabase-js';
import { Button } from './ui/Button';
import { LogOut, User, Menu } from 'lucide-react';

interface HeaderProps {
  session: Session;
  onSignOut: () => void;
  onMenuClick: () => void;
}

export function Header({ session, onSignOut, onMenuClick }: HeaderProps) {
  return (
    <header className="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-30">
      <div className="flex items-center justify-between px-4 sm:px-6 py-4 gap-2">
        <div className="flex items-center gap-3 min-w-0">
          <button onClick={onMenuClick} className="lg:hidden text-gray-600 hover:text-gray-900 p-1 shrink-0" aria-label="Open menu">
            <Menu className="w-6 h-6" />
          </button>
          <h1 className="text-xl font-bold text-gray-800 truncate">Dashboard</h1>
        </div>
        <div className="flex items-center gap-2 sm:gap-4 shrink-0">
          <div className="hidden sm:flex items-center gap-2 text-sm text-gray-600">
            <User className="w-4 h-4" />
            <span>{session.user.email}</span>
          </div>
          <Button variant="ghost" onClick={onSignOut} className="flex items-center gap-2">
            <LogOut className="w-4 h-4" />
            <span className="hidden sm:inline">Sign Out</span>
          </Button>
        </div>
      </div>
    </header>
  );
}
