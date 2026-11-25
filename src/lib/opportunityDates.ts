/** Interpreta datas DATE do Supabase no calendário local, sem deslocamento UTC. */
export function parseOpportunityDate(value: string | null | undefined): Date | null {
  if (!value) return null
  const match = /^(\d{4})-(\d{2})-(\d{2})$/.exec(value)
  if (match) return new Date(Number(match[1]), Number(match[2]) - 1, Number(match[3]))
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? null : date
}

export function isOpportunityExpired(value: string | null | undefined): boolean {
  const deadline = parseOpportunityDate(value)
  if (!deadline) return false
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  return deadline < today
}
