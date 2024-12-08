# ACUAI
## A social network platform for the AI club at ACU

ACUAI is a blogging site, where users can post and comment about artifical intelligence related topics.
Users can see and post announcements and pin important posts like guides.
Our user story is: as a computer science student, i want a blog website so that i can share what i learn,
see what other students are learning, ask questions and find educational materials.

basically hugging face for acu

chatgpt fake posts

---

# COMPLETE FEATURE SET

mvp features:
- Creating an account
- Creating a post
- Commenting on a post
- Uploading files
- Pinning / liking posts
- Filtering and searching posts
- Searching posts

additional features:
- Internationalization
- datasets and visualizations
- model training, evaluation and deployment
- model running
- Rich text editing
- Unit testing
- E mailing
- Sign in e mail confirmation
- Subscription to posts, comments ,users
- Comment liking
- chat rooms
- private messaging
- attachments previews
- user profile pictures
- user profile descriptions
- elastic search
- popular posts
- view counts
- curated feeds

# DEVELOPMENT NOTES

posts have has_many_attached :uploads

uploaded_files have_one_attached :upload

mind the singular/plural naming

---

# SPRINT 1
 TODO

- [x] navbar

- [x] posts index
- [x] post crud
- [x] post show

- [x] comment crud
- [x] comment show

- [x] file upload
- [x] file attachments to posts

- [x] Sign in
- [x] Sign out
- [x] Sign up
- [x] delete account

- [x] user profile show
- [x] user profile edit

- [x] post pin / unpin
- [x] post like / unlike

- [x] topics
- [x] topic show
- [x] topic index
- [x] topic crud
- [x] topic filtering

- [x] post sorting
- [x] post filtering
- [x] post search

- [x] Admin functionality

- [x] Announcements

 STYLING
- [x] 3 part main page

# SPRINT 2
 TODO
- [ ] internationalize the app = Ozge
- [ ] add rich text editing to posts and comments
(use ckeditor or trix) = Arda
- [ ] unit testing = Arda
- [ ] e mailing = Tarik
- [ ] sign in e mail confirmation = Ismail
- [ ] subscription to posts = Ismail
- [ ] subscription to comments = Ismail
- [ ] subscription to users = Ismail
- [x] comment liking = Ismail

 STYLING
- [ ] style _post = Ibrahim
- [ ] style _comment = Ibrahim
- [ ] style post/show = Ibrahim
- [ ] style post/index = Ibrahim
- [ ] style comment/_form = Ibrahim
- [ ] style post/_form = Ibrahim