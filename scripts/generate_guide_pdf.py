"""Generate the Bountiful South Stake History Site user guide PDF."""

from fpdf import FPDF

# Colors
NAVY = (30, 58, 95)
GOLD = (180, 140, 50)
DARK_TEXT = (40, 40, 40)
LIGHT_BG = (245, 245, 240)
WHITE = (255, 255, 255)
MEDIUM_GRAY = (100, 100, 100)


class GuidePDF(FPDF):
    def header(self):
        if self.page_no() == 1:
            return
        self.set_font("Helvetica", "I", 9)
        self.set_text_color(*MEDIUM_GRAY)
        self.cell(0, 8, "Bountiful Utah South Stake History Site  |  history.bountifulsouthstake.org", align="C")
        self.ln(12)

    def footer(self):
        self.set_y(-15)
        self.set_font("Helvetica", "I", 9)
        self.set_text_color(*MEDIUM_GRAY)
        self.cell(0, 10, f"Page {self.page_no()}", align="C")

    def section_title(self, number, title):
        self.ln(4)
        self.set_font("Helvetica", "B", 15)
        self.set_text_color(*NAVY)
        self.cell(0, 10, f"{number}. {title}", new_x="LMARGIN", new_y="NEXT")
        # underline
        self.set_draw_color(*GOLD)
        self.set_line_width(0.8)
        x = self.l_margin
        self.line(x, self.get_y(), x + 170, self.get_y())
        self.ln(5)

    def body_text(self, text):
        self.set_font("Helvetica", "", 12)
        self.set_text_color(*DARK_TEXT)
        self.multi_cell(0, 7, text)
        self.ln(2)

    def step(self, number, text):
        self.set_font("Helvetica", "B", 12)
        self.set_text_color(*NAVY)
        x = self.get_x()
        self.cell(10, 7, f"{number}.")
        self.set_font("Helvetica", "", 12)
        self.set_text_color(*DARK_TEXT)
        self.multi_cell(0, 7, text)
        self.ln(2)

    def bullet(self, text, bold_prefix=""):
        self.set_font("Helvetica", "", 12)
        self.set_text_color(*DARK_TEXT)
        x = self.l_margin
        self.set_x(x + 5)
        self.cell(5, 7, "-")
        if bold_prefix:
            self.set_font("Helvetica", "B", 12)
            self.cell(self.get_string_width(bold_prefix) + 1, 7, bold_prefix)
            self.set_font("Helvetica", "", 12)
            self.multi_cell(0, 7, text)
        else:
            self.multi_cell(0, 7, text)
        self.ln(1)

    def tip_box(self, text):
        self.ln(2)
        self.set_fill_color(*LIGHT_BG)
        x = self.l_margin
        w = self.w - self.l_margin - self.r_margin
        self.set_x(x)
        self.set_font("Helvetica", "I", 11)
        self.set_text_color(*MEDIUM_GRAY)
        y_start = self.get_y()
        self.multi_cell(w, 6.5, f"Tip: {text}", fill=True)
        self.ln(3)


def build_pdf(output_path):
    pdf = GuidePDF(orientation="P", unit="mm", format="Letter")
    pdf.set_auto_page_break(auto=True, margin=20)
    pdf.set_margins(20, 15, 20)

    # ── COVER / PAGE 1 ──────────────────────────────────────────────
    pdf.add_page()

    pdf.ln(30)
    # Title block
    pdf.set_font("Helvetica", "B", 26)
    pdf.set_text_color(*NAVY)
    pdf.multi_cell(0, 12, "Getting Started with the\nBountiful South Stake\nHistory Site", align="C")
    pdf.ln(6)

    pdf.set_font("Helvetica", "", 15)
    pdf.set_text_color(*GOLD)
    pdf.cell(0, 10, "A Simple Guide for Contributors", align="C", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(4)

    # decorative line
    pdf.set_draw_color(*GOLD)
    pdf.set_line_width(1)
    cx = pdf.w / 2
    pdf.line(cx - 40, pdf.get_y(), cx + 40, pdf.get_y())
    pdf.ln(12)

    pdf.set_font("Helvetica", "", 13)
    pdf.set_text_color(*DARK_TEXT)
    pdf.multi_cell(0, 8, (
        "Thank you for helping preserve the history of our stake! "
        "This guide will walk you through everything you need to know, "
        "one step at a time. If you can send a text message or an email, "
        "you can do this. No technical skills required."
    ), align="C")

    pdf.ln(8)
    pdf.set_font("Helvetica", "", 12)
    pdf.set_text_color(*MEDIUM_GRAY)
    pdf.cell(0, 7, "history.bountifulsouthstake.org", align="C", new_x="LMARGIN", new_y="NEXT")

    # ── SECTION 1: Getting to the Site ───────────────────────────────
    pdf.add_page()
    pdf.section_title(1, "Getting to the Site")

    pdf.step(1, 'Open the web browser on your computer or phone. (This is the app you use to visit websites -- it might be called Chrome, Safari, Edge, or Firefox.)')
    pdf.step(2, 'Click in the address bar at the top of the screen -- the long box where website addresses appear.')
    pdf.step(3, 'Type:  history.bountifulsouthstake.org  and press Enter (or tap "Go" on your phone).')
    pdf.step(4, 'You should see the home page! It says "Bountiful Utah South Stake History" across the top and shows a search box with a grid of colored cards below it -- one for each organization, ward, and auxiliary.')

    pdf.tip_box("You can bookmark this page so you don't have to type the address every time. On most browsers, just click the little star near the address bar.")

    # ── SECTION 2: Creating Your Account / Logging In ────────────────
    pdf.section_title(2, "Creating Your Account / Logging In")

    pdf.body_text("You'll need an account to add memories, upload photos, or follow people. It only takes a minute to set up.")
    pdf.ln(1)

    pdf.set_font("Helvetica", "B", 13)
    pdf.set_text_color(*NAVY)
    pdf.cell(0, 8, "To create a new account:", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(2)

    pdf.step(1, 'Click "Sign In" in the top-right corner of the page.')
    pdf.step(2, 'Click the words "Sign Up" (you\'ll see them near the bottom of the sign-in box).')
    pdf.step(3, 'Type your full name, your email address, and choose a password (at least 6 characters). Then type your password again to confirm it.')
    pdf.step(4, 'Click the "Sign Up" button. You\'re in!')

    pdf.ln(1)
    pdf.set_font("Helvetica", "B", 13)
    pdf.set_text_color(*NAVY)
    pdf.cell(0, 8, "To log in next time:", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(2)

    pdf.step(1, 'Click "Sign In" in the top-right corner.')
    pdf.step(2, "Type your email and password, then click Sign In.")

    pdf.tip_box('Forgot your password? On the Sign In screen, click "Forgot Password?" and follow the steps. A reset link will be sent to your email.')

    # ── SECTION 3: Finding People You Know ────────────────────────────
    pdf.section_title(3, "Finding People You Know")

    pdf.body_text("There are a few easy ways to find someone on the site:")

    pdf.set_font("Helvetica", "B", 12)
    pdf.set_text_color(*NAVY)
    pdf.cell(0, 8, "Search by name:", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(1)
    pdf.step(1, "On the home page, look for the search box near the top.")
    pdf.step(2, 'Start typing a person\'s name. After a couple of letters, a list of matching names will appear below the box -- like suggestions on your phone.')
    pdf.step(3, "Click on the person you're looking for. You'll be taken to their page, which shows their callings, photos, and any memories that have been shared.")

    pdf.ln(1)
    pdf.set_font("Helvetica", "B", 12)
    pdf.set_text_color(*NAVY)
    pdf.cell(0, 8, "Browse by calling or ward:", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(1)
    pdf.body_text('On the home page, you\'ll see colored cards for each organization (like "Stake Presidency," "Relief Society," or specific ward names). Click any card to see everyone who has served in that organization over the years.')

    # ── SECTION 4: Following Someone ──────────────────────────────────
    pdf.section_title(4, 'Following Someone ("Watching")')

    pdf.body_text("If you'd like to know when new memories, photos, or updates are added to someone's page, you can watch them. Here's how:")
    pdf.ln(1)

    pdf.step(1, "Go to the person's page (search for them or click their name).")
    pdf.step(2, 'Look for the small bell icon near the top of their page.')
    pdf.step(3, "Click the bell. When it turns solid (filled in), you're watching that person!")
    pdf.step(4, 'To see everyone you\'re watching, click your name in the top-right corner, then click "My Watchlist."')

    pdf.tip_box("You can also choose to receive a weekly email digest that summarizes new activity for the people you're watching. Look for this option on your Watchlist page.")

    # ── SECTION 5: Adding Your Memories ───────────────────────────────
    pdf.add_page()
    pdf.section_title(5, "Adding Your Memories")

    pdf.body_text("This is the heart of the project -- sharing your personal memories and stories about stake leaders you've known. Every memory matters!")
    pdf.ln(1)

    pdf.step(1, 'Go to the person\'s page. Click the "Add" button.')
    pdf.step(2, 'Choose "Memory" from the options that appear.')
    pdf.step(3, "You'll see a simple form. Type your memory or story in the large text box. You have plenty of room (up to about 2,000 characters -- that's roughly a half page of text).")
    pdf.step(4, "Fill in your name and email address if they aren't already filled in. You can also note how you knew this person (family member, friend, ward member, etc.) and the approximate time period.")
    pdf.step(5, 'When you\'re happy with what you\'ve written, click "Submit." Your memory will be reviewed by an administrator and then appear on the person\'s page.')

    pdf.tip_box("Don't worry about making it perfect! A few heartfelt sentences are wonderful. You might share a favorite story, something they taught you, or just what you remember about their service.")

    # ── SECTION 6: Adding a Photo or Portrait ─────────────────────────
    pdf.section_title(6, "Adding a Photo or Portrait")

    pdf.body_text("You can share photos of stake events, activities, or a portrait of an individual. Here's how:")
    pdf.ln(1)

    pdf.step(1, 'Go to the person\'s page and click the "Add" button.')
    pdf.step(2, 'Choose "Photo" (for event or group photos) or "Portrait" (for a headshot of the person).')
    pdf.step(3, 'Click the area that says to choose a file, or drag a photo into the box. A window will open showing the files on your computer -- find the photo you want and double-click it. (Photos can be JPEG, PNG, or other common types.)')
    pdf.step(4, "For portraits, you'll be able to crop the image -- just drag the corners of the box to frame the person's face.")
    pdf.step(5, "Add a caption or description if you'd like, then click Submit.")

    pdf.tip_box("If you have a printed photo, you can take a picture of it with your phone and upload that! It doesn't need to be studio quality -- we just want to preserve the memory.")

    # ── SECTION 7: Tips & Troubleshooting ─────────────────────────────
    pdf.section_title(7, "Tips & Troubleshooting")

    pdf.bullet('"I can\'t find someone." ', "")
    pdf.body_text('Try searching with just their last name first. If they still don\'t appear, they may not be in the system yet. Click "Add" in the top menu to suggest a person, or contact your stake history coordinator.')

    pdf.bullet('"I forgot my password." ', "")
    pdf.body_text('Click "Sign In," then click "Forgot Password?" and type in your email. You\'ll receive an email with a link to create a new password.')

    pdf.bullet('"My photo won\'t upload." ', "")
    pdf.body_text("Make sure the file is a common image type (like .jpg or .png) and isn't too large. If a photo from your phone is very large, try emailing it to yourself first -- email often shrinks photos to a more manageable size.")

    pdf.bullet('"I submitted something but don\'t see it." ', "")
    pdf.body_text("All submissions are reviewed by an administrator before they appear on the site. This usually happens within a few days. Thank you for your patience!")

    pdf.bullet('"The site looks different on my phone." ', "")
    pdf.body_text("The site adjusts its layout to fit your screen. Everything works the same way -- things might just be stacked vertically instead of side by side.")

    # ── Closing ───────────────────────────────────────────────────────
    pdf.ln(6)
    pdf.set_draw_color(*GOLD)
    pdf.set_line_width(0.5)
    cx = pdf.w / 2
    pdf.line(cx - 30, pdf.get_y(), cx + 30, pdf.get_y())
    pdf.ln(6)

    pdf.set_font("Helvetica", "I", 12)
    pdf.set_text_color(*NAVY)
    pdf.multi_cell(0, 7, (
        "Thank you for being part of this effort to preserve our stake's history. "
        "Your stories and photos are priceless. If you have questions, don't hesitate "
        "to reach out to your ward or stake history coordinator."
    ), align="C")

    pdf.output(output_path)
    print(f"PDF saved to {output_path}")


if __name__ == "__main__":
    import sys
    out = sys.argv[1] if len(sys.argv) > 1 else "stake-history-guide.pdf"
    build_pdf(out)
