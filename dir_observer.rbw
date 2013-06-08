require 'net/smtp'
path = "//{servername}/{foldername}"
fc = Dir.glob(File.join(path, '**', '*')).select { |file| File.file?(file) }.count
#puts fc
if fc > 0
	msgstr = <<MESSAGE_END
From: {username} <{useremail}>
To: {recipientname} <{recipientemail}>
Subject: TMV Error Files

There are files in the TMV error folder.
MESSAGE_END
	Net::SMTP.start('{mailserver}') do |smtp|
		smtp.send_message msgstr, '{useremail}', '{recipientemail}'
	end
end
