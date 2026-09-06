export function Logo({ size = 32 }: { size?: number }) {
  return (
    <div
      style={{ width: size, height: size }}
      className="bg-white rounded-lg flex items-center justify-center shadow-lg"
    >
      <span className="font-bold text-primary-700 text-xl">T</span>
    </div>
  );
}
