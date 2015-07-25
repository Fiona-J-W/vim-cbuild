" basic cmake-integration for vim
" Maintainer:   Florian Weber <oss@florianjw.de>
" Version:      0.02

let s:cbuild_plugin_version = '0.01'

if exists("loaded_cbuild_plugin")
	finish
endif
let loaded_cbuild_plugin = 1

" Public Interface:
command! -nargs=* CBuild call s:cbuild(<f-args>)

function! s:Set_build_type(args)
	if len(a:args) < 1
		if exists("g:cbuild_default_build_type")
			let s:build_type=g:cbuild_default_build_type
		else
			let s:build_type="debug"
		endif
	else
		let s:build_type=a:args[0]
	endif
endfunction

function! s:Set_build_target(args)
	if len(a:args) < 2
		let s:build_target=''
	else
		let s:build_target=a:args[1]
	endif
endfunction

function! s:Set_build_dir()
	let s:build_dir_base = finddir('build', '.;')

	if s:build_dir_base == ""
		throw "Unable to find build directory."
	endif
	let s:build_dir = s:build_dir_base."/".s:build_type
	if isdirectory(s:build_dir) == 0
		throw "Build-directory not found: " . s:build_dir
	endif
endfunction

function! s:Set_build_command()
	if filereadable(s:build_dir . '/build.ninja')
		let s:build_command='ninja'
	else
		let s:build_command='make'
	endif
endfunction()

function! s:cbuild(...)
	call s:Set_build_type(a:000)
	call s:Set_build_target(a:000)
	call s:Set_build_dir()
	call s:Set_build_command()

	exec 'cd ' . s:build_dir
	let command='!cmake ../.. && ' . s:build_command . ' ' . s:build_target
	execute(command)
	exec 'cd -'
endfunction

