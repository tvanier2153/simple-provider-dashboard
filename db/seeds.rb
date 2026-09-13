providers = [
  { name: "Dr. Alice Wells", email: "alice@health.example.com" },
  { name: "Dr. Ben Carter", email: "ben@health.example.com" },
  { name: "Dr. Clara Reyes", email: "clara@health.example.com" }
].map { |attrs| Provider.find_or_create_by!(email: attrs[:email]) { |p| p.name = attrs[:name] } }

clients = [
  { name: "Jane Doe", email: "jane@example.com" },
  { name: "John Smith", email: "john@example.com" },
  { name: "Sam Lee", email: "sam@example.com" },
  { name: "Priya Patel", email: "priya@example.com" },
  { name: "Alex Kim", email: "alex@example.com" }
].map { |attrs| Client.find_or_create_by!(email: attrs[:email]) { |c| c.name = attrs[:name] } }

alice, ben, clara = providers
jane, john, sam, priya, alex = clients

[
  [alice, jane, "premium"],
  [ben, jane, "basic"],
  [alice, john, "basic"],
  [ben, sam, "premium"],
  [clara, sam, "premium"],
  [clara, priya, "basic"],
  [alice, alex, "premium"],
  [clara, alex, "basic"]
].each do |provider, client, plan|
  Enrollment.find_or_create_by!(provider: provider, client: client) { |e| e.plan = plan }
end

journal_data = {
  jane.email => [
    ["Feeling good today, slept well.", 3.days.ago],
    ["Mild headache in the afternoon.", 1.day.ago],
    ["Energy is back, went for a walk.", Time.current]
  ],
  john.email => [
    ["Started new medication.", 5.days.ago],
    ["No side effects so far.", 2.days.ago]
  ],
  sam.email => [
    ["Anxious morning but better by evening.", 4.days.ago],
    ["Great workout session.", 2.days.ago],
    ["Meditated for 20 minutes.", 1.day.ago],
    ["Feeling calm and focused.", Time.current]
  ],
  priya.email => [
    ["Low appetite today.", 2.days.ago]
  ],
  alex.email => [
    ["Back pain improved.", 6.days.ago],
    ["Physical therapy helping.", 3.days.ago],
    ["Pain free today!", Time.current]
  ]
}

journal_data.each do |email, entries|
  client = Client.find_by!(email: email)
  entries.each do |body, created_at|
    HealthJournalEntry.find_or_create_by!(client: client, body: body) do |entry|
      entry.created_at = created_at
      entry.updated_at = created_at
    end
  end
end
