;;; publish.el --- Build fluxharmonic.com

;; Copyright (C) 2021 David Wilson <david@fluxharmonic.com>

;; Author: David Wilson <david@fluxharmonic.com>
;; Maintainer: David Wilson <david@fluxharmonic.com>
;; URL: https://github.com/FluxHarmonic/FluxHarmonic.github.io
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.1"))
;; Keywords: hypermedia, blog, feed, rss

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Docs License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Docs License for more details.
;;
;; You should have received a copy of the GNU General Docs License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Usage:
;; emacs -Q --script ./publish.el

;; Make sure to set PROD=true to generate for the real site!

;; Initialize package sources
(require 'package)

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(setq package-user-dir (expand-file-name "./.packages"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install and load weblorg
(unless (package-installed-p 'weblorg)
  (package-install 'weblorg))
(require 'weblorg)

;; Configure the site
(setq flux-site (weblorg-site
                 :name "flux"
                 :base-url (if (string= (getenv "PROD") "true")
                             "https://fluxharmonic.com"
                             "http://localhost:8080")))

;; Customize ox-html export
(setq org-export-with-toc nil
      org-export-with-section-numbers nil)

;; Home page
(weblorg-route
 :name "index"
 :site flux-site
 :input-pattern "content/index.org"
 :template "post.html"
 :output "public/index.html"
 :url "/")

;; Misc pages
(weblorg-route
 :name "pages"
 :site flux-site
 :input-pattern "content/pages/*.org"
 :template "post.html"
 :output "public/{{ slug }}/index.html"
 :url "/{{ slug }}/")

;; Live streams
(weblorg-route
 :name "streams"
 :site flux-site
 :input-pattern "content/live-streams/*.org"
 :template "post.html"
 :output "public/live-streams/{{ slug }}/index.html"
 :url "/live-streams/{{ slug }}/")

;; Live streams index page
(weblorg-route
 :name "streams-index"
 :site flux-site
 :input-pattern "content/live-streams/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "post-index.html"
 :output "public/live-streams/index.html"
 :url "/live-streams/index.html")

;; Live streams RSS feed
(weblorg-route
 :name "streams-feed"
 :input-pattern "content/live-streams/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "feed.xml"
 :output "public/live-streams/rss.xml"
 :url "public/live-streams/rss.xml")

;; Static site assets like images, fonts, etc
(weblorg-copy-static
 :output "public/static/{{ file }}"
 :url "/static/{{ file }}"
 :site flux-site)

;; Export the site
(weblorg-export)

;; Copy the CNAME file
(copy-file "CNAME" "public/CNAME" t)
