desc "IMPORT CSV"
task import_csv: :environment do
    debugger
    file_path = ENV['CSV_FILE_PATH']
    requester_id = ENV['USER_ID'].to_i

    if file_path.present? && File.exist?(file_path) && File.extname(file_path) == '.csv'
      require 'csv'
   
      CSV.foreach(file_path, headers: true) do |row|
        Ticket.create(subject: row['subject'], 
            status: row['status']&.downcase || 'new', 
            requester_id: requester_id,
            content: row['content']
        )
      end
  
      puts 'CSV data imported successfully.'
    else
      puts 'Invalid file path or format. Please provide a valid CSV file.'
    end
end

