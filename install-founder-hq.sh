#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# 🏠 FOUNDER HQ INSTALLER
# One command to set up your AI-powered workspace with Chief of Staff
# ═══════════════════════════════════════════════════════════════════════════════

set -e

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}  🏠 Welcome to Founder HQ Setup${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# Get the user's name (handle both direct run and curl | bash)
if [ -t 0 ]; then
    # Running directly - stdin is a terminal
    read -p "What's your first name? " FOUNDER_NAME
else
    # Running via curl | bash - need to read from /dev/tty
    echo -n "What's your first name? "
    read FOUNDER_NAME < /dev/tty
fi
FOUNDER_NAME=${FOUNDER_NAME:-Founder}

echo ""
echo -e "${YELLOW}Hey $FOUNDER_NAME! Let's set up your AI workspace.${NC}"
echo ""

# Create the base directory
HQ_DIR="$HOME/Founder-HQ"

if [ -d "$HQ_DIR" ]; then
    echo -e "${YELLOW}Looks like you already have a Founder-HQ folder.${NC}"
    echo -n "Want to add missing files? (y/n) "
    if [ -t 0 ]; then
        read -n 1 -r REPLY
    else
        read -n 1 -r REPLY < /dev/tty
    fi
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "No problem! Run this again anytime."
        exit 0
    fi
fi

echo -e "${GREEN}Creating your workspace...${NC}"
echo ""

# Create folder structure
mkdir -p "$HQ_DIR"
mkdir -p "$HQ_DIR/01-Inbox"
mkdir -p "$HQ_DIR/02-Projects"
mkdir -p "$HQ_DIR/03-Clients"
mkdir -p "$HQ_DIR/04-Content"
mkdir -p "$HQ_DIR/04-Content/Drafts"
mkdir -p "$HQ_DIR/04-Content/Published"
mkdir -p "$HQ_DIR/04-Content/Social"
mkdir -p "$HQ_DIR/05-Resources"
mkdir -p "$HQ_DIR/06-Archive"

# Create .claude/commands folder for slash commands
mkdir -p "$HQ_DIR/.claude/commands"

echo "  ✓ Created folder structure"

# ═══════════════════════════════════════════════════════════════════════════════
# CHIEF OF STAFF COMMAND
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/.claude/commands/chief-of-staff.md" << 'CHIEFOFSTAFF'
# Chief of Staff

You are my Chief of Staff. Your job is to know what's going on across my work and help me focus on what actually matters.

## Instructions

1. **Read these files first:**
   - `tasks.md` — what's on my plate
   - `projects.md` — what I'm building
   - `inbox.md` — things that landed but aren't sorted
   - `ideas.md` — thoughts I've dumped
   - `wins.md` — what's been working

2. **Give me a briefing:**

   **What needs attention NOW:**
   - Urgent tasks or deadlines
   - Things that have been sitting too long
   - Anything in inbox that needs a decision

   **What's going well:**
   - Projects making progress
   - Recent wins to build on

   **What I'm noticing:**
   - Patterns (am I overcommitting? neglecting something?)
   - Opportunities (connections between projects, people who could help)
   - Things you might be avoiding

   **Recommended focus:**
   - If you only do ONE thing today, it should be...

3. **Be direct.** Don't soften bad news. If I'm behind on something, say so. If something should be killed, say that too.

4. **Ask me** if anything is unclear or if you need more context.

## Tone

You're not a yes-person. You're the person who tells me what I need to hear, not what I want to hear. Warm but honest.
CHIEFOFSTAFF

echo "  ✓ Created /chief-of-staff command"

# ═══════════════════════════════════════════════════════════════════════════════
# BRAIN DUMP COMMAND
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/.claude/commands/brain-dump.md" << 'BRAINDUMP'
# Brain Dump

I have messy thoughts. Help me sort them.

## Instructions

1. Let me dump everything on my mind - don't interrupt, just listen
2. When I'm done, help me:
   - Identify what's actually urgent vs. what just feels urgent
   - Turn vague worries into specific tasks
   - Spot things that can be deleted, delegated, or deferred
   - Find the 1-2 things that would make the biggest difference

3. Update my files:
   - Add new tasks to `tasks.md`
   - Add project updates to `projects.md`
   - Put half-baked ideas in `ideas.md`
   - Clear out anything from `inbox.md` that we processed

Be a thinking partner, not just a note-taker.
BRAINDUMP

echo "  ✓ Created /brain-dump command"

# ═══════════════════════════════════════════════════════════════════════════════
# WIN COMMAND
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/.claude/commands/win.md" << 'WIN'
# Record a Win

Something worked! Let's capture it.

## Instructions

1. Ask me: "What's the win?"
2. Help me articulate:
   - What happened
   - Why it matters
   - What I did that made it work (so I can repeat it)
3. Add it to `wins.md` with today's date
4. Celebrate briefly, then ask if there's anything to build on this momentum
WIN

echo "  ✓ Created /win command"

# ═══════════════════════════════════════════════════════════════════════════════
# VOICE TO SOCIAL COMMAND
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/.claude/commands/voice-to-social.md" << 'VOICETOSOCIAL'
# Voice to Social

Turn my voice notes into social content.

## Instructions

1. **First, read my voice guide:** Check `voice-guide.md` to understand how I talk, what I care about, and what makes my content sound like ME.

2. **Ask me to paste the transcript** (or I might have already pasted it).

3. **Extract the gold:**
   - What's the core insight or story?
   - What would make someone stop scrolling?
   - What's the emotional hook?

4. **Create content options:**

   **LinkedIn post** (if the idea is professional/business-y):
   - Hook line that creates curiosity
   - The story or insight (conversational, not corporate)
   - A takeaway or question that invites engagement

   **Twitter/X thread** (if it's punchy and can be broken up):
   - Strong opening tweet
   - 3-5 supporting tweets
   - Closer that lands the point

   **Instagram caption** (if it's personal/relatable):
   - Attention-grabbing first line
   - The story (authentic, emoji-friendly if that's my style)
   - Call to action or question

5. **Show me the drafts** and ask which direction feels right.

6. **Save to the right place:**
   - Save drafts to `04-Content/Social/` with today's date
   - If I approve one, move it to "ready to post"

## Important

- Don't make it sound like a robot wrote it
- Keep my quirks and personality
- If something doesn't translate well to social, tell me
- It's okay to say "this might work better as a longer piece"
VOICETOSOCIAL

echo "  ✓ Created /voice-to-social command"

# ═══════════════════════════════════════════════════════════════════════════════
# DEVELOP VOICE COMMAND
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/.claude/commands/develop-voice.md" << 'DEVELOPVOICE'
# Develop My Voice

Help me figure out and document my unique voice.

## Instructions

This is a conversation to build out my `voice-guide.md`. We're creating a reference so Claude always knows how to write like me.

### Ask me about:

**How I talk:**
- Do I use humor? What kind?
- Am I formal or casual?
- Do I swear? Use slang?
- Short punchy sentences or longer flowing ones?

**What I care about:**
- What topics light me up?
- What gets me fired up (in a good way)?
- What gets me fired up (in a frustrated way)?
- What do I want to be known for?

**My audience:**
- Who am I talking to?
- What do they need to hear?
- What language do they use?

**Examples:**
- Ask me to share posts or writing I love (mine or others')
- Ask me to share things that feel "off" or not like me
- Note specific phrases or patterns I use

### As we talk:

1. Take notes on everything
2. When we're done, update `voice-guide.md` with what we discovered
3. Organize it so it's easy for future Claude sessions to reference

### The goal:

By the end, `voice-guide.md` should be a cheat sheet that helps Claude write content that sounds like ME, not like a generic AI.
DEVELOPVOICE

echo "  ✓ Created /develop-voice command"

# Create voice notes folder
mkdir -p "$HQ_DIR/04-Content/Voice-Notes"

# ═══════════════════════════════════════════════════════════════════════════════
# SUPPORTING FILES
# ═══════════════════════════════════════════════════════════════════════════════

# Tasks file
cat > "$HQ_DIR/tasks.md" << 'TASKS'
# Tasks

What's on your plate. Update this as things change.

## This Week
- [ ]

## Soon
- [ ]

## Someday
- [ ]

## Waiting On
<!-- Things blocked by other people -->
- [ ]
TASKS

echo "  ✓ Created tasks.md"

# Projects file
cat > "$HQ_DIR/projects.md" << 'PROJECTS'
# Projects

Your active projects and their status.

## Active Projects

### Project Name
**Status:** Just started / In progress / Almost done
**Goal:** What does "done" look like?
**Next action:** The very next thing to do

---

<!-- Copy the template above for each project -->
PROJECTS

echo "  ✓ Created projects.md"

# Inbox file
cat > "$HQ_DIR/inbox.md" << 'INBOX'
# Inbox

Things that landed but aren't sorted yet. Process regularly with /chief-of-staff.

---


INBOX

echo "  ✓ Created inbox.md"

# Ideas file
cat > "$HQ_DIR/ideas.md" << 'IDEAS'
# Ideas

Brain dumps, half-baked thoughts, things to explore later.

---


IDEAS

echo "  ✓ Created ideas.md"

# Wins file
cat > "$HQ_DIR/wins.md" << 'WINS'
# Wins

Things that worked. Reference this when you need a boost.

---


WINS

echo "  ✓ Created wins.md"

# Voice guide file
cat > "$HQ_DIR/voice-guide.md" << 'VOICEGUIDE'
# My Voice Guide

This is Claude's cheat sheet for writing like ME. Update this as we learn more about my voice.

Run `/develop-voice` to build this out together.

---

## How I Talk

**Tone:**
- [ ] Casual / [ ] Professional / [ ] Mix
- [ ] Playful / [ ] Serious / [ ] Warm
- [ ] Direct / [ ] Diplomatic

**Sentence style:**
- (Short and punchy? Long and flowing? Mix?)

**Words I use:**
- (Favorite phrases, slang, expressions)

**Words I DON'T use:**
- (Corporate speak? Certain buzzwords?)

**Do I swear?**
- [ ] Yes / [ ] No / [ ] Sometimes

**Humor:**
- (What kind? Dry? Self-deprecating? Pop culture references?)

---

## What I Care About

**Topics that light me up:**
-

**Things that frustrate me:**
-

**What I want to be known for:**
-

**My unique perspective:**
- (What do I see that others don't?)

---

## My Audience

**Who am I talking to:**
-

**What they need to hear:**
-

**Language they use:**
-

---

## Examples

### Content I love (mine or others'):
<!-- Paste links or snippets of posts that feel RIGHT -->


### Content that feels "off" or not like me:
<!-- What should Claude avoid? -->


---

## Patterns Claude Has Noticed

<!-- This section gets updated as we work together -->


---

*Last updated: (date)*
VOICEGUIDE

echo "  ✓ Created voice-guide.md"

# ═══════════════════════════════════════════════════════════════════════════════
# CLAUDE.md - THE MAIN MEMORY FILE
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/CLAUDE.md" << 'CLAUDEMD'
# Welcome to Your Founder HQ

This is your personal AI workspace. When you chat with Claude here, it remembers everything in this file.

## About You
- **Name:** FOUNDER_NAME_PLACEHOLDER
- **Focus areas:** Writing, business operations, building tools, staying organized, social media

## Your Commands

Type these to activate different modes:

| Command | What it does |
|---------|--------------|
| `/chief-of-staff` | Get a full briefing on everything - what needs attention, what's going well, what to focus on |
| `/brain-dump` | Dump messy thoughts, Claude helps you sort them into tasks and projects |
| `/win` | Record something that worked so you remember what works |
| `/voice-to-social` | Paste a voice note transcript, get social media content in YOUR voice |
| `/develop-voice` | Build out your voice guide so Claude knows how to write like you |

## What Claude Can Help You With

### Writing & Content
- "Help me write a LinkedIn post about [topic]"
- "Turn these rough notes into a polished email"
- "Help me outline an article about [idea]"
- "Make this sound more [professional/casual/friendly]"

### Business Operations
- "Create a checklist for [process]"
- "Help me write a scope of work for [project]"
- "Draft an email to [client] about [topic]"
- "Organize these notes into action items"

### Social Media
- "Turn this article into 5 tweets"
- "Help me write an Instagram caption for [image description]"
- "Create a content calendar for next week"
- "Repurpose this blog post for LinkedIn"

### Organization
- "Help me organize these files/notes"
- "Create a project tracker for [project]"
- "What should I prioritize this week?"

## Your Files

These files track your work. Claude reads and updates them:

| File | What it's for |
|------|---------------|
| `tasks.md` | What's on your plate |
| `projects.md` | Active projects and their status |
| `inbox.md` | Things that need sorting |
| `ideas.md` | Half-baked thoughts |
| `wins.md` | Things that worked |
| `voice-guide.md` | How YOU talk - so Claude writes like you, not a robot |

## Your Folder Structure

```
Founder-HQ/
├── 01-Inbox/         ← Drop random stuff here, sort later
├── 02-Projects/      ← Active projects you're working on
├── 03-Clients/       ← Client-specific folders
├── 04-Content/       ← Everything you write
│   ├── Drafts/       ← Work in progress
│   ├── Published/    ← Finished pieces
│   ├── Social/       ← Social media content
│   └── Voice-Notes/  ← Voice note transcripts
├── 05-Resources/     ← Templates, swipe files, references
├── 06-Archive/       ← Old stuff you might need
└── .claude/commands/ ← Your custom commands live here
```

## Things I'll Remember

(Add notes here that you want Claude to always know about you)

-

## Pro Tips

1. **Start with /chief-of-staff** - Best way to get oriented
2. **Run /develop-voice first** - Teach Claude how you talk so content sounds like YOU
3. **Voice notes → social** - Record yourself rambling, paste the transcript, run /voice-to-social
4. **Screenshot anything** - Drag screenshots into the chat and ask Claude to help
5. **Don't overthink it** - Just describe what you need in plain English
CLAUDEMD

# Replace placeholder with actual name (works on both macOS and Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/FOUNDER_NAME_PLACEHOLDER/$FOUNDER_NAME/g" "$HQ_DIR/CLAUDE.md"
else
    sed -i "s/FOUNDER_NAME_PLACEHOLDER/$FOUNDER_NAME/g" "$HQ_DIR/CLAUDE.md"
fi

echo "  ✓ Created CLAUDE.md (your memory file)"

# ═══════════════════════════════════════════════════════════════════════════════
# README
# ═══════════════════════════════════════════════════════════════════════════════

cat > "$HQ_DIR/README.md" << 'README'
# Your Founder HQ

This is your AI-powered workspace with a built-in Chief of Staff.

## Quick Start

1. Open Terminal (Cmd + Space, type "Terminal")
2. Type: `cd ~/Founder-HQ`
3. Type: `claude`
4. Type: `/chief-of-staff` for your first briefing!

## Your Commands

- `/chief-of-staff` — Full briefing on everything
- `/brain-dump` — Sort out messy thoughts
- `/win` — Record something that worked
- `/voice-to-social` — Turn voice notes into social content
- `/develop-voice` — Build your voice guide

## Your Files

- `tasks.md` — What's on your plate
- `projects.md` — Active projects
- `inbox.md` — Things to sort
- `ideas.md` — Half-baked thoughts
- `wins.md` — Things that worked
- `voice-guide.md` — How YOU write/talk

## Folders

- **01-Inbox/** - Quick capture, sort later
- **02-Projects/** - One folder per project
- **03-Clients/** - One folder per client
- **04-Content/** - All your writing
- **05-Resources/** - Templates and references
- **06-Archive/** - Old stuff

## Tips

- CLAUDE.md is your "memory" — add notes there
- Just talk naturally, Claude figures it out
- Drag files/screenshots into the chat
README

echo "  ✓ Created README"

# Sample welcome file
cat > "$HQ_DIR/01-Inbox/welcome.md" << 'WELCOME'
# Welcome to your Inbox!

Drop anything here:
- Screenshots
- Voice note transcripts
- Random ideas
- Files you're not sure where to put

Later, run `/chief-of-staff` and Claude will help you sort through it.
WELCOME

echo "  ✓ Added welcome file"

# ═══════════════════════════════════════════════════════════════════════════════
# DONE!
# ═══════════════════════════════════════════════════════════════════════════════

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}  ✨ Your Founder HQ is ready!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "Your workspace is at: ${BOLD}$HQ_DIR${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo ""
echo "  1. Open Terminal (Cmd + Space, type 'Terminal')"
echo ""
echo "  2. Go to your HQ:"
echo -e "     ${BOLD}cd ~/Founder-HQ${NC}"
echo ""
echo "  3. Start Claude:"
echo -e "     ${BOLD}claude${NC}"
echo ""
echo "  4. Get your first briefing:"
echo -e "     ${BLUE}/chief-of-staff${NC}"
echo ""
echo -e "${GREEN}You now have your own AI Chief of Staff. Have fun! 🎉${NC}"
echo ""
