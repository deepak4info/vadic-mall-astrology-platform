export interface Column<T> {
  header: React.ReactNode;
  render: (row: T) => React.ReactNode;
  className?: string;
}

export function AdminTable<T extends { id: string }>({ columns, rows, emptyLabel }: { columns: Column<T>[]; rows: T[]; emptyLabel: string }) {
  if (rows.length === 0) {
    return <div className="rounded-2xl border border-dashed py-16 text-center text-gray-500">{emptyLabel}</div>;
  }

  return (
    <div className="overflow-x-auto rounded-2xl border bg-white">
      <table className="w-full min-w-[600px] text-left text-sm">
        <thead>
          <tr className="border-b bg-gray-50">
            {columns.map((col, i) => (
              <th key={i} className="px-4 py-3 font-semibold text-gray-600">{col.header}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((row) => (
            <tr key={row.id} className="border-b last:border-0 hover:bg-gray-50">
              {columns.map((col, i) => (
                <td key={i} className={`px-4 py-3 ${col.className ?? ""}`}>{col.render(row)}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
