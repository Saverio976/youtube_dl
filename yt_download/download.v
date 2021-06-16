module yt_download

import os { join_path, write_file }
import net.http { get_text, get }

pub fn download_best_audio(id string, path string) ?string {
	info_html_text := get_text('https://www.yt-download.org/api/button/mp3/$id')
	if info_html_text == '' {
		eprintln('non-existent video or bad connection')
		return none
	}
	download_url := parse_best_audio_download_url(info_html_text)  or { return none }
	return download(id, download_url, path, '.mp3') or { return none }
}

pub fn download_video(id string, path string) ?string {
	info_html_text := get_text('https://www.yt-download.org/api/button/videos/$id')
	if info_html_text == '' {
		eprintln('non-existent video or bad connection')
		return none
	}
	download_url := parse_video_download_url(info_html_text) or { return none }
	return download(id, download_url, path, '.mp4') or { return none }
}

fn download(id string, download_url string, path string, target string) ?string {
	html_text := get_text('https://youtube.com/oembed?format=json&url=https://www.youtube.com/watch?v=$id')
	title := parse_video_title(html_text) or { return none }
	mut final_path := join_path(path, title+target)
	resp := get(download_url) or { 
		eprintln('$err')
		return none 
	}
	os.create(final_path) or {
		mut tmp := ''
		for i in 0 .. final_path.len {
			println('${final_path[i]}')
			if final_path[i] > 127 { tmp = tmp + '?' }
			else { tmp = tmp + final_path[i].ascii_str() }
		}
		final_path = tmp
		os.create(final_path) or {
			eprintln('$err')
			return none
		}
	}
	os.write_file(final_path, resp.text) or {
		eprintln('$err')
		return none
	}
	return final_path
}
