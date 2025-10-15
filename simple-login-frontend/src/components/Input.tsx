import { InputHTMLAttributes } from 'react'

interface Props extends InputHTMLAttributes<HTMLInputElement> {
  label: string
  error?: string | null
  helpText?: string
}

export default function Input({ label, error, helpText, className = '', ...props }: Props) {
  const base = 'w-full border rounded-lg px-3 py-2 text-gray-900 placeholder:text-gray-400 focus:outline-none focus:ring-2'
  const normal = 'border-gray-300 focus:ring-gray-800 focus:border-gray-800'
  const errored = 'border-red-300 focus:ring-red-400 focus:border-red-400'
  return (
    <div className="space-y-1">
      <label className="block text-sm font-medium text-gray-700">{label}</label>
      <input className={`${base} ${error ? errored : normal} ${className}`} {...props} />
      {helpText && !error && <p className="text-xs text-gray-500">{helpText}</p>}
      {error && <p className="text-xs text-red-600">{error}</p>}
    </div>
  )
}
