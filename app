import React, { useEffect, useMemo, useState } from "react";

const STORAGE_KEY = "wedding-seating-chart-v1";

const guestSeed = [
  { name: "Phoebe", tag: "Bride" },
  { name: "Ethan", tag: "Groom" },

  { name: "Jesse", tag: "Bridesmaid" },
  { name: "Morgan", tag: "Bridesmaid" },
  { name: "Angie", tag: "Bridesmaid" },
  { name: "Sophie", tag: "Bridesmaid" },

  { name: "Steve", tag: "Groomsman" },
  { name: "Joey", tag: "Groomsman" },
  { name: "Dec", tag: "Groomsman" },
  { name: "Kipp", tag: "Groomsman" },

  { name: "Harrison", tag: "Phoebe's Family" },
  { name: "William", tag: "Phoebe's Family" },
  { name: "Wayne", tag: "Phoebe's Family" },
  { name: "Arrikah", tag: "Phoebe's Family" },
  { name: "Amber", tag: "Phoebe's Family" },
  { name: "Emma", tag: "Phoebe's Family" },
  { name: "Dinah", tag: "Phoebe's Family" },
  { name: "Jack", tag: "Phoebe's Family" },

  { name: "Steven", tag: "Ethan's Family" },
  { name: "Jemima", tag: "Ethan's Family" },
  { name: "Abbie", tag: "Ethan's Family" },
  { name: "Kirsten", tag: "Ethan's Family" },
  { name: "Owen", tag: "Ethan's Family" },
  { name: "Shail", tag: "Ethan's Family" },
  { name: "Helen", tag: "Ethan's Family" },
  { name: "Doug", tag: "Ethan's Family" },

  { name: "Cooper", tag: "Ethan's Work Friends" },
  { name: "Clare", tag: "Ethan's Work Friends" },
  { name: "Jessica Reid", tag: "Ethan's Work Friends" },
  { name: "Frank", tag: "Ethan's Work Friends" },
  { name: "Maria", tag: "Ethan's Work Friends" },

  { name: "Ryan", tag: "Ethan's School Friends" },
  { name: "Jess", tag: "Ethan's School Friends" },
  { name: "Joe", tag: "Ethan's School Friends" },

  { name: "Lachie", tag: "Ethan's Gridiron Friends" },
  { name: "Chris", tag: "Ethan's Gridiron Friends" },
  { name: "Mitch", tag: "Ethan's Gridiron Friends" },
  { name: "Hanna", tag: "Ethan's Gridiron Friends" },
  { name: "Dom", tag: "Ethan's Gridiron Friends" },
  { name: "Camille", tag: "Ethan's Gridiron Friends" },
  { name: "David", tag: "Ethan's Gridiron Friends" },
  { name: "Shae", tag: "Ethan's Gridiron Friends" },
  { name: "Kylie", tag: "Ethan's Gridiron Friends" },
  { name: "Zach", tag: "Ethan's Gridiron Friends" },

  { name: "Katja", tag: "Study Abroad" },
  { name: "Jaz", tag: "Study Abroad" },
  { name: "Rachel", tag: "Study Abroad" },
  { name: "Eden", tag: "Study Abroad" },

  { name: "Alexa", tag: "Phoebe's Work Friends" },
  { name: "Ruby", tag: "Phoebe's Work Friends" },
  { name: "Rose", tag: "Phoebe's Work Friends" },
  { name: "Katie", tag: "Phoebe's Work Friends" },

  { name: "Tatiana", tag: "Phoebe's Uni Friends" },
  { name: "Rae", tag: "Phoebe's Uni Friends" },
  { name: "Jack", tag: "Phoebe's Uni Friends" },
  { name: "Jason", tag: "Phoebe's Uni Friends" },

  { name: "Jarrod", tag: "Phoebe's School Friends" },
  { name: "Andrew", tag: "Phoebe's School Friends" },
  { name: "Jessie", tag: "Phoebe's School Friends" },
  { name: "Gwyn", tag: "Phoebe's School Friends" },
  { name: "Ginny", tag: "Phoebe's School Friends" },
  { name: "Ashka", tag: "Phoebe's School Friends" },
  { name: "Holly", tag: "Phoebe's School Friends" },
  { name: "Keenan", tag: "Phoebe's School Friends" },
  { name: "Callan", tag: "Phoebe's School Friends" },

  { name: "Rob", tag: "Phoebe's Extended Family" },
  { name: "Marie", tag: "Phoebe's Extended Family" },
  { name: "Sam", tag: "Phoebe's Extended Family" },
  { name: "Kerrie", tag: "Phoebe's Extended Family" },

  { name: "Christine", tag: "Ethan's Extended Family" },
  { name: "Emma", tag: "Ethan's Extended Family" },
  { name: "Cameron", tag: "Ethan's Extended Family" },
  { name: "Lewis", tag: "Ethan's Extended Family" },
  { name: "Danielle", tag: "Ethan's Extended Family" },
  { name: "Chloe", tag: "Ethan's Extended Family" },

  { name: "Jac", tag: "Phoebe's Gymnastics Friends" },
  { name: "Janaya", tag: "Phoebe's Gymnastics Friends" },
  { name: "Debbs", tag: "Phoebe's Gymnastics Friends" },
  { name: "Cam", tag: "Phoebe's Gymnastics Friends" },
];

const tagClasses = {
  Bride: "bg-pink-100 text-pink-700 border-pink-200",
  Groom: "bg-sky-100 text-sky-700 border-sky-200",
  Bridesmaid: "bg-rose-100 text-rose-700 border-rose-200",
  Groomsman: "bg-blue-100 text-blue-700 border-blue-200",
  "Phoebe's Family": "bg-fuchsia-100 text-fuchsia-700 border-fuchsia-200",
  "Ethan's Family": "bg-indigo-100 text-indigo-700 border-indigo-200",
  "Ethan's Work Friends": "bg-emerald-100 text-emerald-700 border-emerald-200",
  "Ethan's School Friends": "bg-cyan-100 text-cyan-700 border-cyan-200",
  "Ethan's Gridiron Friends": "bg-green-100 text-green-700 border-green-200",
  "Study Abroad": "bg-violet-100 text-violet-700 border-violet-200",
  "Phoebe's Work Friends": "bg-amber-100 text-amber-700 border-amber-200",
  "Phoebe's Uni Friends": "bg-orange-100 text-orange-700 border-orange-200",
  "Phoebe's School Friends": "bg-yellow-100 text-yellow-700 border-yellow-200",
  "Phoebe's Extended Family": "bg-red-100 text-red-700 border-red-200",
  "Ethan's Extended Family": "bg-slate-200 text-slate-700 border-slate-300",
  "Phoebe's Gymnastics Friends": "bg-teal-100 text-teal-700 border-teal-200",
};

function slugify(value) {
  return value.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
}

function SeatCard({ seat, guest, selectedGuestId, onSeatClick, onSeatDrop, onGuestDragStart, onRemove }) {
  const isSelected = guest && selectedGuestId === guest.id;
  const tagClass = guest ? tagClasses[guest.tag] || "bg-slate-100 text-slate-700 border-slate-200" : "";

  return (
    <div
      onDragOver={(e) => e.preventDefault()}
      onDrop={(e) => onSeatDrop(e, seat.id)}
      onClick={() => onSeatClick(seat.id)}
      className={`rounded-2xl border p-3 transition cursor-pointer ${
        guest
          ? isSelected
            ? "border-slate-900 bg-slate-50 shadow-md"
            : "border-slate-200 bg-white shadow-sm hover:shadow-md"
          : "border-dashed border-slate-300 bg-slate-50 hover:border-slate-400"
      }`}
    >
      <div className="mb-2 flex items-center justify-between gap-2">
        <div className="text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">{seat.label}</div>
        {guest ? (
          <button
            type="button"
            onClick={(e) => {
              e.stopPropagation();
              onRemove(guest.id);
            }}
            className="rounded-full border border-slate-200 px-2 py-0.5 text-[11px] font-medium text-slate-600 hover:bg-slate-100"
          >
            Remove
          </button>
        ) : null}
      </div>

      {guest ? (
        <div
          draggable
          onDragStart={(e) => onGuestDragStart(e, guest.id)}
          className="space-y-2"
        >
          <div className="text-sm font-semibold text-slate-900">{guest.name}</div>
          <div className={`inline-flex rounded-full border px-2 py-1 text-[11px] font-medium ${tagClass}`}>
            {guest.tag}
          </div>
        </div>
      ) : (
        <div className="text-sm text-slate-400">Drop guest here</div>
      )}
    </div>
  );
}

export default function WeddingSeatingChartPlanner() {
  const guests = useMemo(
    () => guestSeed.map((guest, index) => ({ ...guest, id: `${slugify(guest.name)}-${index + 1}` })),
    []
  );

  const seatDefinitions = useMemo(() => {
    const frontSeats = Array.from({ length: 10 }, (_, index) => ({
      id: `F-${index + 1}`,
      label: `Front ${index + 1}`,
      zone: "Front",
      table: 0,
      order: index + 1,
    }));

    const tableSeats = [];
    for (let table = 1; table <= 3; table += 1) {
      for (let order = 1; order <= 24; order += 1) {
        tableSeats.push({
          id: `T${table}-${order}`,
          label: `T${table}.${String(order).padStart(2, "0")}`,
          zone: "Table",
          table,
          order,
        });
      }
    }

    return [...frontSeats, ...tableSeats];
  }, []);

  const [assignments, setAssignments] = useState({});
  const [selectedGuestId, setSelectedGuestId] = useState(null);
  const [search, setSearch] = useState("");
  const [activeTag, setActiveTag] = useState("All");
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    try {
      const saved = window.localStorage.getItem(STORAGE_KEY);
      if (saved) {
        setAssignments(JSON.parse(saved));
      }
    } catch (error) {
      console.error("Could not load seating chart", error);
    }
  }, []);

  useEffect(() => {
    try {
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify(assignments));
    } catch (error) {
      console.error("Could not save seating chart", error);
    }
  }, [assignments]);

  const guestById = useMemo(
    () => Object.fromEntries(guests.map((guest) => [guest.id, guest])),
    [guests]
  );

  const seatById = useMemo(
    () => Object.fromEntries(seatDefinitions.map((seat) => [seat.id, seat])),
    [seatDefinitions]
  );

  const frontSeats = seatDefinitions.filter((seat) => seat.zone === "Front");

  const tables = useMemo(
    () =>
      [1, 2, 3].map((tableNumber) => ({
        number: tableNumber,
        seats: seatDefinitions.filter((seat) => seat.table === tableNumber),
      })),
    [seatDefinitions]
  );

  const assignedGuestIds = useMemo(
    () => new Set(Object.values(assignments).filter(Boolean)),
    [assignments]
  );

  const allTags = useMemo(
    () => ["All", ...Array.from(new Set(guests.map((guest) => guest.tag)))],
    [guests]
  );

  const rawUnassignedGuests = useMemo(
    () => guests.filter((guest) => !assignedGuestIds.has(guest.id)),
    [guests, assignedGuestIds]
  );

  const filteredUnassignedGuests = useMemo(() => {
    return rawUnassignedGuests.filter((guest) => {
      const matchesSearch = guest.name.toLowerCase().includes(search.toLowerCase()) || guest.tag.toLowerCase().includes(search.toLowerCase());
      const matchesTag = activeTag === "All" || guest.tag === activeTag;
      return matchesSearch && matchesTag;
    });
  }, [rawUnassignedGuests, search, activeTag]);

  const groupedUnassignedGuests = useMemo(() => {
    return filteredUnassignedGuests.reduce((accumulator, guest) => {
      if (!accumulator[guest.tag]) {
        accumulator[guest.tag] = [];
      }
      accumulator[guest.tag].push(guest);
      return accumulator;
    }, {});
  }, [filteredUnassignedGuests]);

  function moveGuestToSeat(guestId, targetSeatId) {
    setAssignments((previous) => {
      const next = { ...previous };
      let sourceSeatId = null;

      for (const [seatId, assignedGuestId] of Object.entries(next)) {
        if (assignedGuestId === guestId) {
          sourceSeatId = seatId;
          break;
        }
      }

      if (sourceSeatId === targetSeatId) {
        return previous;
      }

      const displacedGuestId = next[targetSeatId] || null;

      if (sourceSeatId) {
        delete next[sourceSeatId];
      }

      next[targetSeatId] = guestId;

      if (displacedGuestId && sourceSeatId) {
        next[sourceSeatId] = displacedGuestId;
      }

      return next;
    });
  }

  function removeGuestFromSeat(guestId) {
    setAssignments((previous) => {
      const next = { ...previous };
      for (const [seatId, assignedGuestId] of Object.entries(next)) {
        if (assignedGuestId === guestId) {
          delete next[seatId];
          break;
        }
      }
      return next;
    });
    setSelectedGuestId((current) => (current === guestId ? null : current));
  }

  function handleGuestDragStart(event, guestId) {
    event.dataTransfer.effectAllowed = "move";
    event.dataTransfer.setData("text/plain", guestId);
  }

  function handleSeatDrop(event, seatId) {
    event.preventDefault();
    const guestId = event.dataTransfer.getData("text/plain");
    if (!guestId) return;
    moveGuestToSeat(guestId, seatId);
    setSelectedGuestId(null);
  }

  function handleUnassignedDrop(event) {
    event.preventDefault();
    const guestId = event.dataTransfer.getData("text/plain");
    if (!guestId) return;
    removeGuestFromSeat(guestId);
  }

  function handleSeatClick(seatId) {
    const occupantId = assignments[seatId];

    if (selectedGuestId) {
      moveGuestToSeat(selectedGuestId, seatId);
      setSelectedGuestId(null);
      return;
    }

    if (occupantId) {
      setSelectedGuestId((current) => (current === occupantId ? null : occupantId));
    }
  }

  function resetChart() {
    const confirmed = window.confirm("Clear every seat assignment?");
    if (!confirmed) return;
    setAssignments({});
    setSelectedGuestId(null);
  }

  async function copyPlan() {
    const lines = [];

    lines.push("FRONT TABLE");
    frontSeats.forEach((seat) => {
      const guest = guestById[assignments[seat.id]];
      lines.push(`${seat.label}: ${guest ? guest.name : "Empty"}`);
    });

    tables.forEach((table) => {
      lines.push("");
      lines.push(`TABLE ${table.number}`);
      table.seats.forEach((seat) => {
        const guest = guestById[assignments[seat.id]];
        lines.push(`${seat.label}: ${guest ? guest.name : "Empty"}`);
      });
    });

    lines.push("");
    lines.push("UNASSIGNED");
    rawUnassignedGuests.forEach((guest) => lines.push(`${guest.name} (${guest.tag})`));

    try {
      await navigator.clipboard.writeText(lines.join("\n"));
      setCopied(true);
      window.setTimeout(() => setCopied(false), 1800);
    } catch (error) {
      console.error("Could not copy seating plan", error);
    }
  }

  const totalGuests = guests.length;
  const totalSeats = seatDefinitions.length;
  const seatedCount = Object.keys(assignments).length;
  const unassignedCount = totalGuests - seatedCount;
  const spareSeats = totalSeats - totalGuests;
  const selectedGuest = selectedGuestId ? guestById[selectedGuestId] : null;

  return (
    <div className="min-h-screen bg-slate-100 p-4 text-slate-900 md:p-6">
      <div className="mx-auto max-w-7xl space-y-6">
        <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
            <div>
              <div className="mb-2 text-xs font-semibold uppercase tracking-[0.25em] text-slate-500">Wedding Seating Planner</div>
              <h1 className="text-3xl font-bold tracking-tight text-slate-900">Interactive drag-and-drop seating chart</h1>
              <p className="mt-2 max-w-3xl text-sm text-slate-600">
                10 seats at the front, plus 3 tables of 24 arranged as two vertical seat columns of 12. Drag guests into place, drag them back to the unassigned area, or click a guest then click a seat to place them.
              </p>
            </div>

            <div className="flex flex-wrap gap-3">
              <button
                type="button"
                onClick={copyPlan}
                className="rounded-2xl bg-slate-900 px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-slate-800"
              >
                {copied ? "Copied" : "Copy plan"}
              </button>
              <button
                type="button"
                onClick={resetChart}
                className="rounded-2xl border border-slate-300 px-4 py-2.5 text-sm font-semibold text-slate-700 transition hover:bg-slate-50"
              >
                Reset chart
              </button>
            </div>
          </div>
        </div>

        <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
          <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
            <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Guests</div>
            <div className="mt-2 text-3xl font-bold">{totalGuests}</div>
          </div>
          <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
            <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Seated</div>
            <div className="mt-2 text-3xl font-bold">{seatedCount}</div>
          </div>
          <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
            <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Unassigned</div>
            <div className="mt-2 text-3xl font-bold">{unassignedCount}</div>
          </div>
          <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
            <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Spare seats</div>
            <div className="mt-2 text-3xl font-bold">{spareSeats}</div>
          </div>
        </div>

        <div className="grid gap-6 xl:grid-cols-[360px_minmax(0,1fr)]">
          <aside className="space-y-4">
            <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
              <div className="text-sm font-semibold text-slate-900">Guest controls</div>
              <input
                type="text"
                value={search}
                onChange={(event) => setSearch(event.target.value)}
                placeholder="Search guest or tag"
                className="mt-4 w-full rounded-2xl border border-slate-300 px-4 py-3 text-sm outline-none transition focus:border-slate-900"
              />

              <div className="mt-4 flex flex-wrap gap-2">
                {allTags.map((tag) => (
                  <button
                    key={tag}
                    type="button"
                    onClick={() => setActiveTag(tag)}
                    className={`rounded-full border px-3 py-1.5 text-xs font-medium transition ${
                      activeTag === tag
                        ? "border-slate-900 bg-slate-900 text-white"
                        : "border-slate-200 bg-white text-slate-700 hover:bg-slate-50"
                    }`}
                  >
                    {tag}
                  </button>
                ))}
              </div>

              <div className="mt-4 rounded-2xl bg-slate-50 p-4 text-sm text-slate-600">
                {selectedGuest ? (
                  <span>
                    <strong className="text-slate-900">Selected:</strong> {selectedGuest.name}. Click any seat to place or swap.
                  </span>
                ) : (
                  <span>Tip: drag guests directly onto a seat, or click a guest and then click a seat.</span>
                )}
              </div>
            </div>

            <div
              onDragOver={(e) => e.preventDefault()}
              onDrop={handleUnassignedDrop}
              className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm"
            >
              <div className="flex items-center justify-between gap-3">
                <div>
                  <div className="text-sm font-semibold text-slate-900">Unassigned guests</div>
                  <div className="mt-1 text-xs text-slate-500">Drag seated guests back here to remove them from the chart.</div>
                </div>
                <div className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">
                  {filteredUnassignedGuests.length}
                </div>
              </div>

              <div className="mt-4 max-h-[64vh] space-y-4 overflow-y-auto pr-1">
                {Object.keys(groupedUnassignedGuests).length === 0 ? (
                  <div className="rounded-2xl border border-dashed border-slate-300 p-6 text-center text-sm text-slate-400">
                    No guests match the current filters.
                  </div>
                ) : (
                  Object.entries(groupedUnassignedGuests).map(([tag, tagGuests]) => (
                    <div key={tag} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <div className={`inline-flex rounded-full border px-2.5 py-1 text-[11px] font-medium ${tagClasses[tag] || "bg-slate-100 text-slate-700 border-slate-200"}`}>
                          {tag}
                        </div>
                        <div className="text-xs text-slate-500">{tagGuests.length}</div>
                      </div>

                      <div className="grid grid-cols-1 gap-2">
                        {tagGuests.map((guest) => (
                          <button
                            key={guest.id}
                            type="button"
                            draggable
                            onDragStart={(e) => handleGuestDragStart(e, guest.id)}
                            onClick={() => setSelectedGuestId((current) => (current === guest.id ? null : guest.id))}
                            className={`rounded-2xl border px-3 py-3 text-left text-sm font-medium transition ${
                              selectedGuestId === guest.id
                                ? "border-slate-900 bg-slate-900 text-white"
                                : "border-slate-200 bg-white text-slate-800 hover:bg-slate-50"
                            }`}
                          >
                            {guest.name}
                          </button>
                        ))}
                      </div>
                    </div>
                  ))
                )}
              </div>
            </div>
          </aside>

          <main className="space-y-6">
            <div className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
              <div className="mb-4 flex items-center justify-between gap-3">
                <div>
                  <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Front table</div>
                  <div className="mt-1 text-lg font-semibold text-slate-900">10 seats across the top</div>
                </div>
                <div className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">{frontSeats.length} seats</div>
              </div>

              <div className="grid grid-cols-2 gap-3 md:grid-cols-5 xl:grid-cols-10">
                {frontSeats.map((seat) => (
                  <SeatCard
                    key={seat.id}
                    seat={seat}
                    guest={guestById[assignments[seat.id]]}
                    selectedGuestId={selectedGuestId}
                    onSeatClick={handleSeatClick}
                    onSeatDrop={handleSeatDrop}
                    onGuestDragStart={handleGuestDragStart}
                    onRemove={removeGuestFromSeat}
                  />
                ))}
              </div>
            </div>

            <div className="grid gap-6 xl:grid-cols-3">
              {tables.map((table) => {
                const leftColumn = table.seats.slice(0, 12);
                const rightColumn = table.seats.slice(12, 24);

                return (
                  <div key={table.number} className="rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
                    <div className="mb-4 flex items-center justify-between gap-3">
                      <div>
                        <div className="text-xs font-semibold uppercase tracking-[0.2em] text-slate-500">Reception table</div>
                        <div className="mt-1 text-lg font-semibold text-slate-900">Table {table.number}</div>
                      </div>
                      <div className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">24 seats</div>
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <div className="space-y-3">
                        {leftColumn.map((seat) => (
                          <SeatCard
                            key={seat.id}
                            seat={seat}
                            guest={guestById[assignments[seat.id]]}
                            selectedGuestId={selectedGuestId}
                            onSeatClick={handleSeatClick}
                            onSeatDrop={handleSeatDrop}
                            onGuestDragStart={handleGuestDragStart}
                            onRemove={removeGuestFromSeat}
                          />
                        ))}
                      </div>
                      <div className="space-y-3">
                        {rightColumn.map((seat) => (
                          <SeatCard
                            key={seat.id}
                            seat={seat}
                            guest={guestById[assignments[seat.id]]}
                            selectedGuestId={selectedGuestId}
                            onSeatClick={handleSeatClick}
                            onSeatDrop={handleSeatDrop}
                            onGuestDragStart={handleGuestDragStart}
                            onRemove={removeGuestFromSeat}
                          />
                        ))}
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          </main>
        </div>
      </div>
    </div>
  );
}
