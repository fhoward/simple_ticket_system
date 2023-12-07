json.extract! ticket, :id, :requester_id, :status, :subject, :content, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
