module youtugo

import os { join_path, write_file }
import net.http { get_text, get }

pub fn download_audio(id string, path string) ?string {
	info_html_text := get_text('https://www.youtugo.com/api/audio/$id')
	if info_html_text == '' {
		eprintln('non-existent video or bad connection')
		return none
	}
	return download(info_html_text, path, '.mp3') or { return none }
}

pub fn download_video(id string, path string) ?string {
	info_html_text := get_text('https://www.youtugo.com/api/video/$id')
	if info_html_text == '' {
		eprintln('non-existent video or bad connection')
		return none
	}
	return download(info_html_text, path, '.mp4') or { return none }
}

fn download(html_text string, path string, target string) ?string {
	title := parse_video_title(html_text) or { return none }
	download_url := parse_download_url(html_text) or { return none }
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
