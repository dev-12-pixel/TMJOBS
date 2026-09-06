'use client';
import { useAuth } from '@/hooks/useAuth';
import { useRouter } from 'next/navigation';
import { Sidebar } from './Sidebar';
import { Header } from './Header';
import { ReactNode } from 'react';

export function Layout({ children }: { children: ReactNode }) {
  const { session, signOut } = useAuth();
  const router = useRouter();

  if (!session) {
    router.push('/');
    return null;
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Sidebar />
      <main className="lg:ml-64">
        <Header session={session} onSignOut={signOut} />
        <div className="p-6">{children}</div>
      </main>
    </div>
  );
}
