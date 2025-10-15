import type { ButtonHTMLAttributes, ReactNode } from 'react'

interface Props extends ButtonHTMLAttributes<HTMLButtonElement> {
  loading?: boolean
  children: ReactNode
}

export default function Button({ loading, children, className = '', ...props }: Props) {
  return (
    <button
      {...props}
      className={`w-full inline-flex items-center justify-center gap-2 bg-gray-900 text-white py-2.5 rounded-lg hover:bg-black transition-colors focus:outline-none focus:ring-2 focus:ring-gray-900 disabled:opacity-60 ${className}`}
      disabled={loading || props.disabled}
    >
      {loading && (
        <span className="h-4 w-4 animate-spin rounded-full border-2 border-white/60 border-t-transparent"></span>
      )}
      {loading ? 'Working...' : children}
    </button>
  )}
