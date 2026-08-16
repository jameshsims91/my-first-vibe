quotes = [
  # Tech
  { text: "Any sufficiently advanced technology is indistinguishable from magic.", author: "Arthur C. Clarke", category: "tech" },
  { text: "The best way to predict the future is to invent it.", author: "Alan Kay", category: "tech" },
  { text: "Technology is best when it brings people together.", author: "Matt Mullenweg", category: "tech" },
  { text: "First we build the tools, then they build us.", author: "Marshall McLuhan", category: "tech" },
  { text: "It's not a faith in technology. It's faith in people.", author: "Steve Jobs", category: "tech" },
  { text: "The Internet is becoming the town square for the global village of tomorrow.", author: "Bill Gates", category: "tech" },
  { text: "Move fast and break things. Unless you are breaking stuff, you are not moving fast enough.", author: "Mark Zuckerberg", category: "tech" },

  # Startup
  { text: "Make something people want.", author: "Paul Graham", category: "startup" },
  { text: "The only way to do great work is to love what you do.", author: "Steve Jobs", category: "startup" },
  { text: "Ideas are easy. Implementation is hard.", author: "Guy Kawasaki", category: "startup" },
  { text: "If you're not embarrassed by the first version of your product, you've launched too late.", author: "Reid Hoffman", category: "startup" },
  { text: "Don't worry about failure; you only have to be right once.", author: "Drew Houston", category: "startup" },
  { text: "Chase the vision, not the money; the money will end up following you.", author: "Tony Hsieh", category: "startup" },
  { text: "Your most unhappy customers are your greatest source of learning.", author: "Bill Gates", category: "startup" },
  { text: "Risk more than others think is safe. Dream more than others think is practical.", author: "Howard Schultz", category: "startup" },

  # Coding
  { text: "Talk is cheap. Show me the code.", author: "Linus Torvalds", category: "coding" },
  { text: "Programs must be written for people to read, and only incidentally for machines to execute.", author: "Harold Abelson", category: "coding" },
  { text: "First, solve the problem. Then, write the code.", author: "John Johnson", category: "coding" },
  { text: "Code is like humor. When you have to explain it, it's bad.", author: "Cory House", category: "coding" },
  { text: "Simplicity is the soul of efficiency.", author: "Austin Freeman", category: "coding" },
  { text: "The most disastrous thing that you can ever learn is your first programming language.", author: "Alan Kay", category: "coding" },
  { text: "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.", author: "Martin Fowler", category: "coding" },
  { text: "Make it work, make it right, make it fast.", author: "Kent Beck", category: "coding" }
]

quotes.each do |attrs|
  Quote.find_or_create_by!(text: attrs[:text]) do |quote|
    quote.author = attrs[:author]
    quote.category = attrs[:category]
  end
end

puts "Seeded #{Quote.count} quotes (#{Quote.group(:category).count})"
