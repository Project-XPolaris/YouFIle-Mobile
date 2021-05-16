import 'package:flutter/material.dart';

ImageProvider getFileIcon(String type,String name){
  if (type == "Directory") {

    return AssetImage("assets/folder.png");
  }
  if (type == "Parted") {
    return AssetImage("assets/disk.png");
  }
  var ext = name.split(".").last;
  switch (ext) {
    case '3ds':
      return AssetImage("assets/3ds.png");
    case 'apk':
      return AssetImage("assets/apk.png");
    case 'asp':
      return AssetImage("assets/asp.png");
    case 'avi':
      return AssetImage("assets/avi.png");
    case 'sh':
      return AssetImage("assets/bash.png");
    case 'epub':
    case 'mobi':
      return AssetImage("assets/bash.png");
    case 'bz':
    case 'bz2':
      return AssetImage("assets/bz2.png");
    case 'c':
      return AssetImage("assets/c.png");
    case 'cmd':
    case 'bat':
      return AssetImage("assets/cmd.png");
    case 'conf':
    case 'cfg':
      return AssetImage("assets/cmd.png");
    case 'cpp':
      return AssetImage("assets/cpp.png");
    case 'csharp':
      return AssetImage("assets/csharp.png");
    case 'css':
      return AssetImage("assets/csharp.png");
    case 'csv':
      return AssetImage("assets/csv.png");
    case 'dart':
      return AssetImage("assets/dart.png");
    case 'deb':
      return AssetImage("assets/deb.png");
    case 'doc':
    case 'docx':
      return AssetImage("assets/doc.png");
    case 'dwg':
      return AssetImage("assets/dwg.png");
    case 'exe':
      return AssetImage("assets/exe.png");
    case 'flac':
      return AssetImage("assets/flac.png");
    case 'ttf':
      return AssetImage("assets/font.png");
    case 'gif':
      return AssetImage("assets/font.png");
    case 'go':
      return AssetImage("assets/go.png");
    case 'h':
      return AssetImage("assets/header.png");
    case 'html':
      return AssetImage("assets/html.png");
    case 'img':
    case 'iso':
      return AssetImage("assets/img.png");
    case 'ink':
      return AssetImage("assets/ink.png");
    case 'java':
      return AssetImage("assets/java.png");
    case 'js':
      return AssetImage("assets/js.png");
    case 'json':
      return AssetImage("assets/json.png");
    case 'kt':
      return AssetImage("assets/kotlin.png");
    case 'log':
      return AssetImage("assets/log.png");
    case 'lua':
      return AssetImage("assets/lua.png");
    case 'md':
      return AssetImage("assets/markdown.png");
    case 'mkv':
      return AssetImage("assets/mkv.png");
    case 'mov':
      return AssetImage("assets/mov.png");
    case 'mp3':
      return AssetImage("assets/mp3.png");
    case 'mp4':
      return AssetImage("assets/mp4.png");
    case 'msi':
      return AssetImage("assets/msi.png");
    case 'ogg':
      return AssetImage("assets/ogg.png");
    case 'pdf':
      return AssetImage("assets/pdf.png");
    case 'psd':
      return AssetImage("assets/pds.png");
    case 'php':
      return AssetImage("assets/php.png");
    case 'png':
      return AssetImage("assets/png.png");
    case 'jpg':
      return AssetImage("assets/image.png");
    case 'ps':
    case 'ps1':
      return AssetImage("assets/powershell.png");
    case 'py':
      return AssetImage("assets/python.png");
    case 'rar':
      return AssetImage("assets/rar.png");
    case 'rmvb':
      return AssetImage("assets/rmvb.png");
    case 'rpm':
      return AssetImage("assets/rpm.png");
    case 'rb':
      return AssetImage("assets/ruby.png");
    case 'rs':
      return AssetImage("assets/rust.png");
    case 'rs':
      return AssetImage("assets/rust.png");
    case 'sql':
      return AssetImage("assets/sql.png");
    case 'srt':
    case 'ass':
      return AssetImage("assets/subtitles.png");
    case 'swift':
      return AssetImage("assets/swift.png");
    case 'tar':
      return AssetImage("assets/tar.png");
    case 'torrent':
      return AssetImage("assets/torrent.png");
    case 'ts':
      return AssetImage("assets/ts.png");
    case 'txt':
      return AssetImage("assets/txt.png");
    case 'wav':
      return AssetImage("assets/wav.png");
    case 'xls':
    case 'xlsx':
      return AssetImage("assets/xls.png");
    case 'xml':
      return AssetImage("assets/xml.png");
    case 'yaml':
    case 'yml':
      return AssetImage("assets/yaml.png");
    case 'zip':
      return AssetImage("assets/zip.png");
  }
  return AssetImage("assets/empty.png");
}