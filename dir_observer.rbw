<<<<<<< HEAD
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
=======
#utility to monitor a directory for error files and generate an email notification if error files exist
#
require 'net/smtp'
#enter server and folder name for script to watch
path = "//{servername}/{foldername}"
fc = Dir.glob(File.join(path, '**', '*')).select { |file| File.file?(file) }.count
#if error files exist create message string and send message over smtp
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
>>>>>>> 23804616dc1f48a6d276aa330fc37eb8641b8aff
