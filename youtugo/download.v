module youtugo

import os { join_path }
import net.http { get, download_file }

// download_audio (mp3) with the youtube video <id> in the <dir> directory
pub fn download_audio(id string, dir string) ?string {
	url := 'https://www.youtugo.com/api/audio/' + id
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| GET: ' + url)
	}
	r := get(url) or { return err }
	if r.status_code != 200 {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| GET: reveived a $r.status_code status code')
		}
		return error('reveived a $r.status_code status code')
	}
	path := download(r.text, dir, '.mp3') or { return err }
	return path
}

// download_video (mp4) with the youtube video <id> in the <dir> directory
pub fn download_video(id string, dir string) ?string {
	url := 'https://www.youtugo.com/api/video/' + id
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| GET: ' + url)
	}
	r := get(url) or { return err }
	if r.status_code != 200 {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| GET: reveived a $r.status_code status code')
		}
		return error('reveived a $r.status_code status code')
	}
	path := download(r.text, dir, '.mp4') or { return err } 
	return path
}

fn download(html_text string, dir string, target string) ?string {
	title := parse_video_title(html_text) or { return err }
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| INFO: download file title : $title')
	}
	download_url := parse_download_url(html_text) or { return err }
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| INFO: download file url : $download_url')
	}
	mut final_path := join_path(dir, title + target)
	final_path.replace_each(['\\',' ', '/',' ', ':',' ', '*',' ', '?',' ', '"',' ', '<',' ', '>',' ', '|',' '])
	download_file(download_url, final_path) or { return err }
	return final_path
}
