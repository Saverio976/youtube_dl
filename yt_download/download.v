module yt_download

import os { join_path }
import net.http { get, download_file }

// download_best_audio (mp3) with the youtube video <id> in the <dir> directory
pub fn download_best_audio(id string, dir string) ?string {
	url := 'https://www.yt-download.org/api/button/mp3/' + id
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
	download_url := parse_best_audio_download_url(r.text)  or { return err }
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| INFO: download file url : $download_url')
	}
	path := download(id, download_url, dir, '.mp3') or { return err }
	return path
}

// download_video (mp4) with the youtube video <id> in the <dir> directory
pub fn download_video(id string, dir string) ?string {
	url := 'https://www.yt-download.org/api/button/videos/' + id
	$if debug {
		println('GET ' + url)
	}
	r := get(url) or { return err }
	if r.status_code != 200 {
		return error('reveived a $r.status_code status code')
	}
	download_url := parse_video_download_url(r.text) or { return err }
	$if debug {
		println('file : ' + @FILE + ' | line : ' + @LINE + '| INFO: download file url : $download_url')
	}
	path := download(id, download_url, dir, '.mp4') or { return err } 
	return path
}

fn download(id string, download_url string, dir string, target string) ?string {
	url := 'https://www.youtube.com/watch?v=' + id
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
	title := parse_video_title(r.text) or { return err }
	mut final_path := join_path(dir, title + target)
	final_path.replace_each(['\\',' ', '/',' ', ':',' ', '*',' ', '?',' ', '"',' ', '<',' ', '>',' ', '|',' '])
	download_file(download_url, final_path) or { return err }
	return final_path
}
