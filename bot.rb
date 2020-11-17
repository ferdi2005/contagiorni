require 'date'
require 'telegram/bot'

if !File.exist? "#{__dir__}/.config"
    puts 'Inserisci token del bot:'
    print '> '
    token = gets.chomp
    puts "Inserisci data dell'evento in Inglese:"
    print '> '
    date = gets.chomp
    puts "Inserisci descrizione dell'evento:"
    print '> '
    event = gets.chomp
    puts "Inserisci chat_id del gruppo:"
    print '> '
    chat_id = gets.chomp
    File.open("#{__dir__}/.config", "w") do |file| 
      file.puts token
      file.puts date
      file.puts event
      file.puts chat_id
    end
  end  
userdata = File.open("#{__dir__}/.config", "r").to_a

userdata.map { |e| e.strip! }
Telegram::Bot::Client.run(userdata[0]) do |bot|
    if Date.today < Date.parse(userdata[1])
        bot.api.send_message(chat_id: userdata[3], text: "Mancano #{(Date.parse(userdata[1]) - Date.today).to_i} giorni #{userdata[2]}")
    end
end