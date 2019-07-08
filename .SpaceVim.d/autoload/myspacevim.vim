function! PasteHabits()
  for line in readfile(expand('~/Nextcloud/wiki/habits.wiki'))
    execute "normal! i" . line . "\n"
  endfor
endf
function! myspacevim#before() abort
  let wiki = {}
  let wiki.path = '~/Nextcloud/wiki/'
  let wiki.path_html = '~/public_html/'
  let wiki.template_path = '~/src/github.com/mauromorales/pkb/templates'
  let wiki.template_default = 'default'
  let wiki.template_ext = '.html'
  let wiki.auto_diary_index = 1
  let wiki.auto_export = 1
  let wiki.auto_toc = 1
  let wiki.auto_tags = 1
  let g:vimwiki_list = [wiki]
  nnoremap <Leader>wa :e ~/Nextcloud/wiki/diary/activity.wiki<cr>
  nnoremap <Leader>wph :call PasteHabits()<cr>
  nnoremap <Leader>wpa :read !acg ~/Nextcloud/wiki/diary/<cr>
endf
function! myspacevim#after() abort
  iunmap <Leader>wa
  iunmap <Leader>wph
  iunmap <Leader>wpa
endf
