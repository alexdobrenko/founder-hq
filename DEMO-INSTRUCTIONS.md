# Founder HQ Demo for Britt

## The One-Liner (After you host the script)

If you upload to GitHub Gist, Britt can run:
```bash
curl -sL https://gist.githubusercontent.com/YOUR_USERNAME/GIST_ID/raw/install-founder-hq.sh | bash
```

## For Today's Demo (30 min)

### Option A: Walk Through It Live (Recommended)
1. Share your screen
2. Open Terminal on your Mac
3. Run the installer yourself to show her what happens:
   ```bash
   /Users/sash/HQ-Clean/02-Projects/founder-hq-installer/install-founder-hq.sh
   ```
4. Then have her try on her machine by:
   - Sending her the script file via Slack
   - Having her double-click it (won't work) → explain she needs Terminal
   - Guide her: "Open Spotlight (Cmd+Space), type Terminal, press Enter"
   - Have her drag the script file INTO the Terminal window and press Enter

### Option B: Screen Control (if she's comfortable)
1. Ask to control her screen via Zoom
2. Open Terminal for her
3. Run the installer

### Option C: Send Raw Commands (Most Manual)
Send her these commands one at a time via Slack:

```bash
# Step 1: Create the folders
mkdir -p ~/Founder-HQ/{01-Inbox,02-Projects,03-Clients,04-Content/{Drafts,Published,Social},05-Resources,06-Archive}
```

```bash
# Step 2: Download the CLAUDE.md (you'd need to host this)
curl -sL [YOUR_URL]/CLAUDE.md > ~/Founder-HQ/CLAUDE.md
```

---

## Making Claude Easier to Start

After setup, she can add this to her ~/.zshrc for quick access:
```bash
alias hq='cd ~/Founder-HQ && claude'
```

Then she just types `hq` to open her workspace.

---

## Visual Interface Options (V2)

### Quick Win: Warp Terminal (Free)
- Download: https://www.warp.dev
- Modern terminal that feels like an IDE
- AI built-in, autocomplete, easier to read
- **Good first upgrade for someone scared of Terminal**

### Alternative: Claude Desktop App
- If she doesn't need file access, Claude Desktop is friendliest
- But loses the folder integration

### Build a Custom Web UI (Future)
- Simple Electron or web wrapper around Claude CLI
- Big buttons: "Help me write", "Organize files", etc.
- Could be a cool product for your course

---

## During the Demo

### Things to Show Britt:
1. **The folder structure** - Open Finder, show her ~/Founder-HQ
2. **The CLAUDE.md file** - "This is Claude's memory about you"
3. **Starting a conversation** - `cd ~/Founder-HQ && claude`
4. **Screenshot trick** - Drag a screenshot into the chat
5. **Simple asks** - "Help me write a LinkedIn post about X"

### Questions She Might Ask:
- "Where does this stuff get saved?" → In her Founder-HQ folder
- "Is Claude reading my files?" → Only in this folder, only when you ask
- "What if I mess up?" → You can't break anything, just start over
- "Do I need to know coding?" → Nope, just talk to it like a person

---

## Quick Reference for Britt

Copy-paste cheatsheet to send her after:

```
HOW TO USE YOUR FOUNDER HQ
==========================

1. Open Terminal (Cmd + Space, type "Terminal")

2. Go to your HQ:
   cd ~/Founder-HQ

3. Start Claude:
   claude

4. Talk to it! Try:
   - "Help me write an email to [client]"
   - "Summarize what's in my Inbox folder"
   - "Create a project folder for [project name]"

5. To quit Claude, press Ctrl+C or type "exit"

TIPS:
- Drag files into the chat to share them
- Screenshots work too!
- The CLAUDE.md file is Claude's memory - add notes there
```
