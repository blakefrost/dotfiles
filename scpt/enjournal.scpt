on handle_string(entry)
	set sdate to do shell script "date '+%m/%d/%y'"
	tell application "Evernote" to open note window with (create note with text entry title sdate notebook "Journal")
end handle_string