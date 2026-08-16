#!/usr/bin/env python3
"""
Project Line of Code (LOC) Counter
===================================
A fast, feature-rich, language-aware code statistics and line counter tool.
Zero external dependencies - works with pure Python 3.8+ standard library.
"""

from __future__ import annotations

import argparse
import csv
import fnmatch
import json
import os
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Set, Tuple

# Version
__version__ = "2.0.0"

# ==============================================================================
# Language Definitions & Comment Syntaxes
# ==============================================================================

@dataclass(frozen=True)
class LanguageDef:
    name: str
    extensions: Tuple[str, ...]
    filenames: Tuple[str, ...] = ()
    line_comments: Tuple[str, ...] = ()
    block_comment_start: Optional[str] = None
    block_comment_end: Optional[str] = None


LANGUAGES: List[LanguageDef] = [
    # Mobile & Modern App Dev
    LanguageDef("Dart", (".dart",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Kotlin", (".kt", ".kts"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Swift", (".swift",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Java", (".java",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Objective-C", (".m", ".mm"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    
    # Systems & Compiled
    LanguageDef("C", (".c", ".h"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("C++", (".cpp", ".cxx", ".cc", ".hpp", ".hxx", ".hh"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("C#", (".cs",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Rust", (".rs",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Go", (".go",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Zig", (".zig",), line_comments=("//",)),
    LanguageDef("Scala", (".scala", ".sc"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Groovy", (".groovy", ".gvy", ".gy", ".gsh"), filenames=("Jenkinsfile",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    
    # Scripting & Dynamic
    LanguageDef("Python", (".py", ".pyw", ".pyi"), line_comments=("#",), block_comment_start='"""', block_comment_end='"""'),
    LanguageDef("Ruby", (".rb", ".rake", ".gemspec"), filenames=("Gemfile", "Rakefile"), line_comments=("#",), block_comment_start="=begin", block_comment_end="=end"),
    LanguageDef("PHP", (".php", ".phtml", ".php3", ".php4", ".php5", ".phps"), line_comments=("//", "#"), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Perl", (".pl", ".pm", ".t"), line_comments=("#",), block_comment_start="=pod", block_comment_end="=cut"),
    LanguageDef("Lua", (".lua",), line_comments=("--",), block_comment_start="--[[", block_comment_end="]]"),
    LanguageDef("R", (".r", ".R"), line_comments=("#",)),
    LanguageDef("Julia", (".jl",), line_comments=("#",), block_comment_start="#=", block_comment_end="=#"),
    LanguageDef("Elixir", (".ex", ".exs"), line_comments=("#",)),
    LanguageDef("Erlang", (".erl", ".hrl"), line_comments=("%",)),
    LanguageDef("Haskell", (".hs", ".lhs"), line_comments=("--",), block_comment_start="{-", block_comment_end="-}"),
    
    # Web & Frontend
    LanguageDef("JavaScript", (".js", ".mjs", ".cjs", ".jsx"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("TypeScript", (".ts", ".mts", ".cts", ".tsx"), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("HTML", (".html", ".htm", ".xhtml"), line_comments=(), block_comment_start="<!--", block_comment_end="-->"),
    LanguageDef("CSS", (".css",), line_comments=(), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("SCSS", (".scss",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Sass", (".sass",), line_comments=("//",)),
    LanguageDef("Less", (".less",), line_comments=("//",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("Vue", (".vue",), line_comments=("//",), block_comment_start="<!--", block_comment_end="-->"),
    LanguageDef("Svelte", (".svelte",), line_comments=("//",), block_comment_start="<!--", block_comment_end="-->"),
    
    # Shell & DevOps
    LanguageDef("Shell", (".sh", ".bash", ".zsh", ".ksh"), line_comments=("#",)),
    LanguageDef("PowerShell", (".ps1", ".psm1", ".psd1"), line_comments=("#",), block_comment_start="<#", block_comment_end="#>"),
    LanguageDef("Batch", (".bat", ".cmd"), line_comments=("REM", "rem", "::")),
    LanguageDef("Dockerfile", (".dockerfile",), filenames=("Dockerfile", "Containerfile"), line_comments=("#",)),
    LanguageDef("Makefile", (".mk", ".mak"), filenames=("Makefile", "makefile", "GNUmakefile"), line_comments=("#",)),
    LanguageDef("CMake", (".cmake",), filenames=("CMakeLists.txt",), line_comments=("#",)),
    
    # Data & Config
    LanguageDef("JSON", (".json", ".jsonc", ".json5"), line_comments=("//",)),
    LanguageDef("YAML", (".yaml", ".yml"), line_comments=("#",)),
    LanguageDef("TOML", (".toml",), line_comments=("#",)),
    LanguageDef("XML", (".xml", ".xsd", ".xsl", ".plist", ".svg"), line_comments=(), block_comment_start="<!--", block_comment_end="-->"),
    LanguageDef("INI/Properties", (".ini", ".cfg", ".conf", ".properties", ".env"), line_comments=("#", ";")),
    LanguageDef("SQL", (".sql", ".psql"), line_comments=("--",), block_comment_start="/*", block_comment_end="*/"),
    LanguageDef("GraphQL", (".graphql", ".gql"), line_comments=("#",)),
    LanguageDef("Protocol Buffers", (".proto",), line_comments=("//",)),
    
    # Documentation & Markup
    LanguageDef("Markdown", (".md", ".markdown", ".mdown"), line_comments=(), block_comment_start="<!--", block_comment_end="-->"),
    LanguageDef("LaTeX", (".tex", ".sty", ".cls"), line_comments=("%",)),
    LanguageDef("Text", (".txt", ".rst", ".asciidoc", ".adoc")),
]

# Map extension -> LanguageDef, and filename -> LanguageDef
EXT_MAP: Dict[str, LanguageDef] = {}
FILENAME_MAP: Dict[str, LanguageDef] = {}

for lang in LANGUAGES:
    for ext in lang.extensions:
        EXT_MAP[ext.lower()] = lang
    for fname in lang.filenames:
        FILENAME_MAP[fname.lower()] = lang

# Binary file extensions that should be skipped from line counting
KNOWN_BINARY_EXTENSIONS: Set[str] = {
    # Images
    ".png", ".jpg", ".jpeg", ".gif", ".webp", ".ico", ".bmp", ".tiff", ".psd", ".raw", ".heic", ".avif",
    # Audio/Video
    ".mp3", ".wav", ".ogg", ".flac", ".aac", ".m4a", ".mp4", ".mov", ".avi", ".mkv", ".webm", ".flv",
    # Fonts
    ".ttf", ".otf", ".woff", ".woff2", ".eot",
    # Archives & Packages
    ".zip", ".tar", ".gz", ".tgz", ".bz2", ".xz", ".7z", ".rar", ".iso", ".apk", ".aab", ".jar", ".war", ".aar",
    # Binaries & Libraries
    ".exe", ".dll", ".so", ".dylib", ".bin", ".out", ".app", ".lib", ".a", ".o", ".obj", ".class", ".pyc", ".pyo", ".pyd",
    # Databases & Caches
    ".db", ".sqlite", ".sqlite3", ".realm", ".dat", ".cache", ".idx", ".pack",
    # Documents
    ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx",
    # OS
    ".ds_store",
}

# Default ignored directories (exact match or standard patterns)
DEFAULT_IGNORE_DIRS: Set[str] = {
    ".git", ".dart_tool", "build", ".idea", ".vscode", ".idx", "node_modules",
    "Pods", ".gradle", "dist", "out", "__pycache__", ".mypy_cache", ".pytest_cache",
    ".firebase", "coverage", ".pub-cache", ".svn", ".hg", "target", "vendor",
    ".next", ".nuxt", ".cache", "DerivedData", ".bundle", ".cargo", ".tox",
    ".venv", "venv", "env", ".env"
}

# Default ignored filenames
DEFAULT_IGNORE_FILES: Set[str] = {
    "pubspec.lock", "package-lock.json", "yarn.lock", "pnpm-lock.yaml",
    "Cargo.lock", "Gemfile.lock", "composer.lock", ".DS_Store", "Thumbs.db",
    ".flutter-plugins-dependencies",
}

# Default ignored wildcard patterns
DEFAULT_IGNORE_PATTERNS: List[str] = [
    "*.min.js", "*.min.css", "*.map", "*.g.dart.tmp"
]


# ==============================================================================
# GitIgnore Matcher
# ==============================================================================

class GitIgnoreRule:
    def __init__(self, pattern: str, base_dir: Path, is_negation: bool, dir_only: bool):
        self.pattern = pattern
        self.base_dir = base_dir
        self.is_negation = is_negation
        self.dir_only = dir_only

    def matches(self, rel_path: str, is_dir: bool) -> bool:
        if self.dir_only and not is_dir:
            return False
        
        pattern = self.pattern
        if "/" in pattern.rstrip("/"):
            # Path-based match
            return fnmatch.fnmatch(rel_path, pattern) or fnmatch.fnmatch(rel_path, pattern.lstrip("/"))
        else:
            # Name-based match across any folder level
            parts = rel_path.split(os.sep)
            filename = parts[-1]
            return fnmatch.fnmatch(filename, pattern) or any(fnmatch.fnmatch(p, pattern) for p in parts)


class GitIgnoreParser:
    def __init__(self, root_path: Path):
        self.root_path = root_path
        self.rules: List[GitIgnoreRule] = []
        self._load_gitignore(root_path / ".gitignore", root_path)

    def _load_gitignore(self, file_path: Path, base_dir: Path) -> None:
        if not file_path.is_file():
            return
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                for line in f:
                    line = line.strip()
                    if not line or line.startswith("#"):
                        continue
                    
                    is_negation = line.startswith("!")
                    if is_negation:
                        line = line[1:].strip()

                    dir_only = line.endswith("/")
                    line = line.rstrip("/")
                    
                    if line:
                        self.rules.append(GitIgnoreRule(line, base_dir, is_negation, dir_only))
        except Exception:
            pass

    def is_ignored(self, path: Path, is_dir: bool = False) -> bool:
        try:
            rel = path.relative_to(self.root_path).as_posix()
        except ValueError:
            rel = path.as_posix()
            
        ignored = False
        for rule in self.rules:
            if rule.matches(rel, is_dir):
                ignored = not rule.is_negation
        return ignored


# ==============================================================================
# Data Structures
# ==============================================================================

@dataclass
class FileStats:
    path: Path
    language: str
    total_lines: int = 0
    code_lines: int = 0
    comment_lines: int = 0
    blank_lines: int = 0
    size_bytes: int = 0


@dataclass
class LanguageStats:
    language: str
    files: int = 0
    total_lines: int = 0
    code_lines: int = 0
    comment_lines: int = 0
    blank_lines: int = 0
    size_bytes: int = 0

    def add_file(self, fs: FileStats) -> None:
        self.files += 1
        self.total_lines += fs.total_lines
        self.code_lines += fs.code_lines
        self.comment_lines += fs.comment_lines
        self.blank_lines += fs.blank_lines
        self.size_bytes += fs.size_bytes


@dataclass
class DirectoryStats:
    directory: str
    files: int = 0
    total_lines: int = 0
    code_lines: int = 0
    comment_lines: int = 0
    blank_lines: int = 0
    size_bytes: int = 0

    def add_file(self, fs: FileStats) -> None:
        self.files += 1
        self.total_lines += fs.total_lines
        self.code_lines += fs.code_lines
        self.comment_lines += fs.comment_lines
        self.blank_lines += fs.blank_lines
        self.size_bytes += fs.size_bytes


@dataclass
class ProjectStats:
    root_path: Path
    file_stats: List[FileStats] = field(default_factory=list)
    skipped_files: List[Tuple[Path, str]] = field(default_factory=list)

    @property
    def total_files(self) -> int:
        return len(self.file_stats)

    @property
    def total_lines(self) -> int:
        return sum(f.total_lines for f in self.file_stats)

    @property
    def code_lines(self) -> int:
        return sum(f.code_lines for f in self.file_stats)

    @property
    def comment_lines(self) -> int:
        return sum(f.comment_lines for f in self.file_stats)

    @property
    def blank_lines(self) -> int:
        return sum(f.blank_lines for f in self.file_stats)

    @property
    def size_bytes(self) -> int:
        return sum(f.size_bytes for f in self.file_stats)

    def by_language(self) -> Dict[str, LanguageStats]:
        result: Dict[str, LanguageStats] = {}
        for fs in self.file_stats:
            if fs.language not in result:
                result[fs.language] = LanguageStats(language=fs.language)
            result[fs.language].add_file(fs)
        return result

    def by_directory(self, depth: int = 1) -> Dict[str, DirectoryStats]:
        result: Dict[str, DirectoryStats] = {}
        for fs in self.file_stats:
            try:
                rel = fs.path.relative_to(self.root_path)
                parts = rel.parts
                if len(parts) <= 1:
                    dir_key = "."
                else:
                    dir_parts = parts[:min(depth, len(parts) - 1)]
                    dir_key = os.path.join(*dir_parts)
            except Exception:
                dir_key = "."
            
            if dir_key not in result:
                result[dir_key] = DirectoryStats(directory=dir_key)
            result[dir_key].add_file(fs)
        return result


# ==============================================================================
# Line Counting Engine
# ==============================================================================

def is_binary_file(file_path: Path) -> bool:
    """Checks if a file is binary by looking at known extensions or testing for null bytes."""
    suffix = file_path.suffix.lower()
    if suffix in KNOWN_BINARY_EXTENSIONS:
        return True
    
    try:
        with open(file_path, "rb") as f:
            chunk = f.read(4096)
            if b"\x00" in chunk:
                return True
            # Try decoding sample
            try:
                chunk.decode("utf-8")
            except UnicodeDecodeError:
                try:
                    chunk.decode("latin-1")
                except UnicodeDecodeError:
                    return True
        return False
    except Exception:
        return True


def count_lines_in_file(file_path: Path, lang_def: Optional[LanguageDef]) -> FileStats:
    """Counts blank, comment, and code lines accurately for a given file."""
    stat = file_path.stat()
    size = stat.st_size
    lang_name = lang_def.name if lang_def else "Plain Text"

    blank_lines = 0
    comment_lines = 0
    code_lines = 0
    total_lines = 0

    # If no comment definitions, count non-empty lines as code
    if not lang_def or (not lang_def.line_comments and not lang_def.block_comment_start):
        try:
            with open(file_path, "r", encoding="utf-8", errors="replace") as f:
                for line in f:
                    total_lines += 1
                    stripped = line.strip()
                    if not stripped:
                        blank_lines += 1
                    else:
                        code_lines += 1
        except Exception:
            with open(file_path, "rb") as f:
                for line in f:
                    total_lines += 1
                    stripped = line.strip()
                    if not stripped:
                        blank_lines += 1
                    else:
                        code_lines += 1
        return FileStats(
            path=file_path,
            language=lang_name,
            total_lines=total_lines,
            code_lines=code_lines,
            comment_lines=comment_lines,
            blank_lines=blank_lines,
            size_bytes=size,
        )

    # With comment syntax parsing
    in_block_comment = False
    block_start = lang_def.block_comment_start
    block_end = lang_def.block_comment_end
    line_comments = lang_def.line_comments

    try:
        with open(file_path, "r", encoding="utf-8", errors="replace") as f:
            for raw_line in f:
                total_lines += 1
                line = raw_line.strip()

                if not line:
                    blank_lines += 1
                    continue

                if in_block_comment:
                    comment_lines += 1
                    if block_end and block_end in line:
                        idx = line.find(block_end)
                        remainder = line[idx + len(block_end):].strip()
                        if remainder and not any(remainder.startswith(lc) for lc in line_comments):
                            pass
                        in_block_comment = False
                    continue

                # Single-line comment check
                if any(line.startswith(lc) for lc in line_comments):
                    comment_lines += 1
                    continue

                # Multi-line comment start check
                if block_start and block_start in line:
                    if line.startswith(block_start):
                        if block_end and block_end in line[len(block_start):]:
                            idx = line.find(block_end, len(block_start))
                            remainder = line[idx + len(block_end):].strip()
                            if remainder:
                                code_lines += 1
                            else:
                                comment_lines += 1
                        else:
                            comment_lines += 1
                            in_block_comment = True
                        continue

                # Regular code line
                code_lines += 1

    except Exception:
        # Fallback to binary byte scan
        with open(file_path, "rb") as f:
            for line in f:
                total_lines += 1
                stripped = line.strip()
                if not stripped:
                    blank_lines += 1
                else:
                    code_lines += 1

    return FileStats(
        path=file_path,
        language=lang_name,
        total_lines=total_lines,
        code_lines=code_lines,
        comment_lines=comment_lines,
        blank_lines=blank_lines,
        size_bytes=size,
    )


def identify_language(file_path: Path) -> Optional[LanguageDef]:
    """Identifies programming language by filename or extension."""
    fname_lower = file_path.name.lower()
    if fname_lower in FILENAME_MAP:
        return FILENAME_MAP[fname_lower]
    
    ext = file_path.suffix.lower()
    if ext in EXT_MAP:
        return EXT_MAP[ext]
    
    return None


def scan_project(
    project_path: Path,
    include_exts: Optional[Set[str]] = None,
    exclude_patterns: Optional[List[str]] = None,
    use_default_ignore: bool = True,
    use_gitignore: bool = True,
) -> ProjectStats:
    """Scans project directory and collects line count statistics."""
    project_path = project_path.resolve()
    stats = ProjectStats(root_path=project_path)
    gitignore_parser = GitIgnoreParser(project_path) if use_gitignore else None

    # Prepare custom exclude patterns
    all_exclude_patterns = []
    if use_default_ignore:
        all_exclude_patterns.extend(DEFAULT_IGNORE_PATTERNS)
    if exclude_patterns:
        all_exclude_patterns.extend(exclude_patterns)

    # Normalize include extensions and language names (e.g. "dart" -> ".dart", "python" -> ".py", ".pyw", etc.)
    norm_includes: Optional[Set[str]] = None
    lang_filter: Optional[Set[str]] = None
    if include_exts:
        norm_includes = set()
        lang_filter = set()
        for item in include_exts:
            item_clean = item.strip().lower()
            matched_lang = False
            for lang in LANGUAGES:
                if lang.name.lower() == item_clean:
                    lang_filter.add(lang.name.lower())
                    for ext in lang.extensions:
                        norm_includes.add(ext.lower())
                    for fname in lang.filenames:
                        norm_includes.add(fname.lower())
                    matched_lang = True
            if not matched_lang:
                if not item_clean.startswith("."):
                    norm_includes.add(f".{item_clean}")
                else:
                    norm_includes.add(item_clean)

    for dirpath, dirnames, filenames in os.walk(project_path):
        current_dir = Path(dirpath)

        # Filter directories in-place to avoid descending into ignored trees
        filtered_dirnames = []
        for d in dirnames:
            dir_full = current_dir / d
            d_lower = d.lower()

            if use_default_ignore and d_lower in DEFAULT_IGNORE_DIRS:
                continue
            if gitignore_parser and gitignore_parser.is_ignored(dir_full, is_dir=True):
                continue
            if any(fnmatch.fnmatch(d, pat) for pat in all_exclude_patterns):
                continue

            filtered_dirnames.append(d)
        dirnames[:] = filtered_dirnames

        # Process files
        for filename in filenames:
            file_path = current_dir / filename
            fname_lower = filename.lower()
            ext = file_path.suffix.lower()

            if use_default_ignore and fname_lower in DEFAULT_IGNORE_FILES:
                continue

            if any(fnmatch.fnmatch(filename, pat) for pat in all_exclude_patterns):
                continue

            if gitignore_parser and gitignore_parser.is_ignored(file_path, is_dir=False):
                continue

            lang_def = identify_language(file_path)

            if norm_includes is not None:
                is_included = (
                    ext in norm_includes
                    or fname_lower in norm_includes
                    or (lang_def is not None and lang_filter is not None and lang_def.name.lower() in lang_filter)
                )
                if not is_included:
                    continue

            # Check binary files
            if is_binary_file(file_path):
                stats.skipped_files.append((file_path, "Binary file"))
                continue

            try:
                file_stat = count_lines_in_file(file_path, lang_def)
                stats.file_stats.append(file_stat)
            except Exception as e:
                stats.skipped_files.append((file_path, str(e)))

    return stats


# ==============================================================================
# Formatters & CLI Output
# ==============================================================================

class Colors:
    """ANSI color codes for terminal formatting."""
    HEADER = "\033[95m"
    BLUE = "\033[94m"
    CYAN = "\033[96m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    BOLD = "\033[1m"
    DIM = "\033[2m"
    UNDERLINE = "\033[4m"
    RESET = "\033[0m"


def format_size(bytes_num: int) -> str:
    """Formats bytes into human readable string (KB, MB, GB)."""
    for unit in ["B", "KB", "MB", "GB"]:
        if bytes_num < 1024.0:
            return f"{bytes_num:3.1f} {unit}"
        bytes_num /= 1024.0
    return f"{bytes_num:.1f} TB"


def render_terminal_table(
    stats: ProjectStats,
    color: bool = True,
    show_top: int = 0,
    by_dir: bool = False,
    dir_depth: int = 1,
    by_file: bool = False,
) -> str:
    """Renders a beautiful ASCII/Unicode table for terminal display."""
    c_bold = Colors.BOLD if color else ""
    c_cyan = Colors.CYAN if color else ""
    c_green = Colors.GREEN if color else ""
    c_yellow = Colors.YELLOW if color else ""
    c_dim = Colors.DIM if color else ""
    c_reset = Colors.RESET if color else ""
    c_blue = Colors.BLUE if color else ""

    lines: List[str] = []

    # Title header
    lines.append("")
    lines.append(f"{c_bold}{c_cyan}======================================================================={c_reset}")
    lines.append(f"{c_bold}{c_cyan}                      PROJECT CODE METRICS                            {c_reset}")
    lines.append(f"{c_dim} Path: {stats.root_path}{c_reset}")
    lines.append(f"{c_bold}{c_cyan}======================================================================={c_reset}")
    lines.append("")

    # Summary Cards
    comment_pct = (stats.comment_lines / stats.total_lines * 100) if stats.total_lines > 0 else 0
    code_pct = (stats.code_lines / stats.total_lines * 100) if stats.total_lines > 0 else 0
    lines.append(
        f" {c_bold}Total Files:{c_reset} {c_green}{stats.total_files:,}{c_reset}  |  "
        f"{c_bold}Code Lines:{c_reset} {c_cyan}{stats.code_lines:,}{c_reset} ({code_pct:.1f}%)  |  "
        f"{c_bold}Comments:{c_reset} {c_yellow}{stats.comment_lines:,}{c_reset} ({comment_pct:.1f}%)  |  "
        f"{c_bold}Size:{c_reset} {format_size(stats.size_bytes)}"
    )
    lines.append("")

    # 1. Language Breakdown Table
    lang_stats = sorted(stats.by_language().values(), key=lambda x: x.code_lines, reverse=True)
    
    w_lang, w_files, w_lines, w_blank, w_comment, w_code, w_pct = 20, 8, 11, 10, 10, 11, 8
    
    # Table Header
    lines.append(f"┌{'─' * w_lang}┬{'─' * w_files}┬{'─' * w_lines}┬{'─' * w_blank}┬{'─' * w_comment}┬{'─' * w_code}┬{'─' * w_pct}┐")
    lines.append(
        f"│{c_bold}{' Language':<{w_lang}}{c_reset}"
        f"│{c_bold}{' Files':>{w_files}}{c_reset}"
        f"│{c_bold}{' Lines':>{w_lines}}{c_reset}"
        f"│{c_bold}{' Blank':>{w_blank}}{c_reset}"
        f"│{c_bold}{' Comment':>{w_comment}}{c_reset}"
        f"│{c_bold}{' Code':>{w_code}}{c_reset}"
        f"│{c_bold}{' Code %':>{w_pct}}{c_reset}│"
    )
    lines.append(f"├{'─' * w_lang}┼{'─' * w_files}┼{'─' * w_lines}┼{'─' * w_blank}┼{'─' * w_comment}┼{'─' * w_code}┼{'─' * w_pct}┤")

    for ls in lang_stats:
        pct = (ls.code_lines / stats.code_lines * 100) if stats.code_lines > 0 else 0
        lines.append(
            f"│ {ls.language:<{w_lang - 1}}"
            f"│ {ls.files:>{w_files - 1}} "
            f"│ {ls.total_lines:>{w_lines - 1},} "
            f"│ {c_dim}{ls.blank_lines:>{w_blank - 1},}{c_reset} "
            f"│ {c_yellow}{ls.comment_lines:>{w_comment - 1},}{c_reset} "
            f"│ {c_green}{ls.code_lines:>{w_code - 1},}{c_reset} "
            f"│ {pct:>{w_pct - 2}.1f}% │"
        )

    lines.append(f"├{'─' * w_lang}┼{'─' * w_files}┼{'─' * w_lines}┼{'─' * w_blank}┼{'─' * w_comment}┼{'─' * w_code}┼{'─' * w_pct}┤")
    # Total row
    lines.append(
        f"│{c_bold}{' TOTAL':<{w_lang}}{c_reset}"
        f"│{c_bold}{stats.total_files:>{w_files - 1}} {c_reset}"
        f"│{c_bold}{stats.total_lines:>{w_lines - 1},} {c_reset}"
        f"│{c_bold}{stats.blank_lines:>{w_blank - 1},} {c_reset}"
        f"│{c_bold}{stats.comment_lines:>{w_comment - 1},} {c_reset}"
        f"│{c_bold}{c_cyan}{stats.code_lines:>{w_code - 1},} {c_reset}"
        f"│{c_bold}{'100.0%':>{w_pct - 1}} {c_reset}│"
    )
    lines.append(f"└{'─' * w_lang}┴{'─' * w_files}┴{'─' * w_lines}┴{'─' * w_blank}┴{'─' * w_comment}┴{'─' * w_code}┴{'─' * w_pct}┘")
    lines.append("")

    # 2. Directory Breakdown (if requested)
    if by_dir:
        dir_stats = sorted(stats.by_directory(depth=dir_depth).values(), key=lambda x: x.code_lines, reverse=True)
        w_dir = 32
        lines.append(f"{c_bold}{c_blue} Directory Breakdown (depth={dir_depth}):{c_reset}")
        lines.append(f"┌{'─' * w_dir}┬{'─' * w_files}┬{'─' * w_lines}┬{'─' * w_comment}┬{'─' * w_code}┬{'─' * w_pct}┐")
        lines.append(
            f"│{c_bold}{' Directory':<{w_dir}}{c_reset}"
            f"│{c_bold}{' Files':>{w_files}}{c_reset}"
            f"│{c_bold}{' Lines':>{w_lines}}{c_reset}"
            f"│{c_bold}{' Comment':>{w_comment}}{c_reset}"
            f"│{c_bold}{' Code':>{w_code}}{c_reset}"
            f"│{c_bold}{' Code %':>{w_pct}}{c_reset}│"
        )
        lines.append(f"├{'─' * w_dir}┼{'─' * w_files}┼{'─' * w_lines}┼{'─' * w_comment}┼{'─' * w_code}┼{'─' * w_pct}┤")
        for ds in dir_stats:
            pct = (ds.code_lines / stats.code_lines * 100) if stats.code_lines > 0 else 0
            dir_display = ds.directory if len(ds.directory) < w_dir - 1 else "..." + ds.directory[-(w_dir - 4):]
            lines.append(
                f"│ {dir_display:<{w_dir - 1}}"
                f"│ {ds.files:>{w_files - 1}} "
                f"│ {ds.total_lines:>{w_lines - 1},} "
                f"│ {c_yellow}{ds.comment_lines:>{w_comment - 1},}{c_reset} "
                f"│ {c_green}{ds.code_lines:>{w_code - 1},}{c_reset} "
                f"│ {pct:>{w_pct - 2}.1f}% │"
            )
        lines.append(f"└{'─' * w_dir}┴{'─' * w_files}┴{'─' * w_lines}┴{'─' * w_comment}┴{'─' * w_code}┴{'─' * w_pct}┘")
        lines.append("")

    # 3. Top N Largest Files (if requested)
    if show_top > 0:
        top_files = sorted(stats.file_stats, key=lambda x: x.code_lines, reverse=True)[:show_top]
        w_file = 45
        lines.append(f"{c_bold}{c_blue} Top {min(show_top, len(top_files))} Files by Code Lines:{c_reset}")
        lines.append(f"┌{'─' * w_file}┬{'─' * 14}┬{'─' * w_code}┬{'─' * w_comment}┬{'─' * w_lines}┐")
        lines.append(
            f"│{c_bold}{' File':<{w_file}}{c_reset}"
            f"│{c_bold}{' Language':<14}{c_reset}"
            f"│{c_bold}{' Code':>{w_code}}{c_reset}"
            f"│{c_bold}{' Comment':>{w_comment}}{c_reset}"
            f"│{c_bold}{' Total':>{w_lines}}{c_reset}│"
        )
        lines.append(f"├{'─' * w_file}┼{'─' * 14}┼{'─' * w_code}┼{'─' * w_comment}┼{'─' * w_lines}┤")
        for f in top_files:
            try:
                rel = str(f.path.relative_to(stats.root_path))
            except Exception:
                rel = f.path.name
            file_display = rel if len(rel) < w_file - 1 else "..." + rel[-(w_file - 4):]
            lines.append(
                f"│ {file_display:<{w_file - 1}}"
                f"│ {f.language:<13} "
                f"│ {c_green}{f.code_lines:>{w_code - 1},}{c_reset} "
                f"│ {c_yellow}{f.comment_lines:>{w_comment - 1},}{c_reset} "
                f"│ {f.total_lines:>{w_lines - 1},} │"
            )
        lines.append(f"└{'─' * w_file}┴{'─' * 14}┴{'─' * w_code}┴{'─' * w_comment}┴{'─' * w_lines}┘")
        lines.append("")

    # 4. File-by-file view (if requested)
    if by_file:
        all_files = sorted(stats.file_stats, key=lambda x: str(x.path))
        w_file = 50
        lines.append(f"{c_bold}{c_blue} All Project Files ({len(all_files)} files):{c_reset}")
        lines.append(f"┌{'─' * w_file}┬{'─' * 12}┬{'─' * 9}┬{'─' * 9}┬{'─' * 9}┬{'─' * 10}┐")
        lines.append(
            f"│{c_bold}{' File':<{w_file}}{c_reset}"
            f"│{c_bold}{' Language':<12}{c_reset}"
            f"│{c_bold}{' Blank':>9}{c_reset}"
            f"│{c_bold}{' Comment':>9}{c_reset}"
            f"│{c_bold}{' Code':>9}{c_reset}"
            f"│{c_bold}{' Total':>10}{c_reset}│"
        )
        lines.append(f"├{'─' * w_file}┼{'─' * 12}┼{'─' * 9}┼{'─' * 9}┼{'─' * 9}┼{'─' * 10}┤")
        for f in all_files:
            try:
                rel = str(f.path.relative_to(stats.root_path))
            except Exception:
                rel = f.path.name
            file_display = rel if len(rel) < w_file - 1 else "..." + rel[-(w_file - 4):]
            lines.append(
                f"│ {file_display:<{w_file - 1}}"
                f"│ {f.language:<11} "
                f"│ {f.blank_lines:>8,} "
                f"│ {c_yellow}{f.comment_lines:>8,}{c_reset} "
                f"│ {c_green}{f.code_lines:>8,}{c_reset} "
                f"│ {f.total_lines:>9,} │"
            )
        lines.append(f"└{'─' * w_file}┴{'─' * 12}┴{'─' * 9}┴{'─' * 9}┴{'─' * 9}┴{'─' * 10}┘")
        lines.append("")

    return "\n".join(lines)


def render_markdown_table(stats: ProjectStats, show_top: int = 0) -> str:
    """Renders statistics as a clean Markdown document / table."""
    lines: List[str] = []
    lines.append(f"# Code Statistics: `{stats.root_path.name}`\n")
    lines.append(f"**Total Files:** {stats.total_files:,} | **Total Lines:** {stats.total_lines:,} | **Code Lines:** {stats.code_lines:,} | **Size:** {format_size(stats.size_bytes)}\n")
    
    lines.append("## Breakdown by Language\n")
    lines.append("| Language | Files | Blank | Comment | Code | Total Lines | Code % |")
    lines.append("| :--- | ---: | ---: | ---: | ---: | ---: | ---: |")
    
    lang_stats = sorted(stats.by_language().values(), key=lambda x: x.code_lines, reverse=True)
    for ls in lang_stats:
        pct = (ls.code_lines / stats.code_lines * 100) if stats.code_lines > 0 else 0
        lines.append(f"| **{ls.language}** | {ls.files:,} | {ls.blank_lines:,} | {ls.comment_lines:,} | {ls.code_lines:,} | {ls.total_lines:,} | {pct:.1f}% |")
    
    lines.append(f"| **TOTAL** | **{stats.total_files:,}** | **{stats.blank_lines:,}** | **{stats.comment_lines:,}** | **{stats.code_lines:,}** | **{stats.total_lines:,}** | **100.0%** |")
    
    if show_top > 0:
        top_files = sorted(stats.file_stats, key=lambda x: x.code_lines, reverse=True)[:show_top]
        lines.append(f"\n## Top {min(show_top, len(top_files))} Largest Files\n")
        lines.append("| File | Language | Blank | Comment | Code | Total Lines |")
        lines.append("| :--- | :--- | ---: | ---: | ---: | ---: |")
        for f in top_files:
            try:
                rel = str(f.path.relative_to(stats.root_path))
            except Exception:
                rel = f.path.name
            lines.append(f"| `{rel}` | {f.language} | {f.blank_lines:,} | {f.comment_lines:,} | {f.code_lines:,} | {f.total_lines:,} |")

    return "\n".join(lines)


def render_json(stats: ProjectStats) -> str:
    """Exports project statistics as structured JSON."""
    data = {
        "root_path": str(stats.root_path),
        "total_files": stats.total_files,
        "total_lines": stats.total_lines,
        "code_lines": stats.code_lines,
        "comment_lines": stats.comment_lines,
        "blank_lines": stats.blank_lines,
        "size_bytes": stats.size_bytes,
        "languages": [
            {
                "language": ls.language,
                "files": ls.files,
                "blank": ls.blank_lines,
                "comment": ls.comment_lines,
                "code": ls.code_lines,
                "total": ls.total_lines,
                "code_percentage": round((ls.code_lines / stats.code_lines * 100), 2) if stats.code_lines > 0 else 0,
            }
            for ls in sorted(stats.by_language().values(), key=lambda x: x.code_lines, reverse=True)
        ],
        "files": [
            {
                "path": str(f.path.relative_to(stats.root_path)) if str(f.path).startswith(str(stats.root_path)) else str(f.path),
                "language": f.language,
                "blank": f.blank_lines,
                "comment": f.comment_lines,
                "code": f.code_lines,
                "total": f.total_lines,
                "size_bytes": f.size_bytes,
            }
            for f in stats.file_stats
        ],
        "skipped_files": [
            {"path": str(p), "reason": reason} for p, reason in stats.skipped_files
        ],
    }
    return json.dumps(data, indent=2)


def render_csv(stats: ProjectStats) -> str:
    """Exports language statistics as CSV."""
    import io
    output = io.StringIO()
    writer = csv.writer(output)
    writer.writerow(["Language", "Files", "Blank", "Comment", "Code", "Total", "CodePercentage", "SizeBytes"])
    for ls in sorted(stats.by_language().values(), key=lambda x: x.code_lines, reverse=True):
        pct = round((ls.code_lines / stats.code_lines * 100), 2) if stats.code_lines > 0 else 0
        writer.writerow([ls.language, ls.files, ls.blank_lines, ls.comment_lines, ls.code_lines, ls.total_lines, pct, ls.size_bytes])
    writer.writerow(["TOTAL", stats.total_files, stats.blank_lines, stats.comment_lines, stats.code_lines, stats.total_lines, 100.0, stats.size_bytes])
    return output.getvalue()


# ==============================================================================
# CLI Main Entry Point
# ==============================================================================

def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="count_project_line_of_code.py",
        description="A fast, feature-rich, language-aware Line of Code (LOC) counter.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python count_project_line_of_code.py                      # Scan current directory with beautiful table
  python count_project_line_of_code.py /path/to/project     # Scan specific directory
  python count_project_line_of_code.py . --top 10           # Show top 10 largest files
  python count_project_line_of_code.py . --by-dir           # Group breakdown by directory / module
  python count_project_line_of_code.py . -i dart yaml       # Only count Dart and YAML files
  python count_project_line_of_code.py . -e "test/*"        # Exclude tests
  python count_project_line_of_code.py . --markdown         # Output as GitHub Markdown table
  python count_project_line_of_code.py . --json             # Output structured JSON
        """,
    )
    parser.add_argument(
        "path",
        nargs="?",
        default=None,
        help="Path to project directory (defaults to current directory or prompt)",
    )
    parser.add_argument(
        "-t", "--top",
        type=int,
        default=0,
        metavar="N",
        help="Show top N largest files by code lines (e.g. --top 10)",
    )
    parser.add_argument(
        "-d", "--by-dir",
        action="store_true",
        help="Show line count breakdown grouped by top-level directories / modules",
    )
    parser.add_argument(
        "--dir-depth",
        type=int,
        default=1,
        help="Directory grouping depth when using --by-dir (default: 1)",
    )
    parser.add_argument(
        "-f", "--by-file",
        action="store_true",
        help="Show detailed statistics for every individual file",
    )
    parser.add_argument(
        "-i", "--include",
        nargs="+",
        metavar="EXT",
        help="Include only specific file extensions or languages (e.g. -i dart yaml or -i .dart .py)",
    )
    parser.add_argument(
        "-e", "--exclude",
        nargs="+",
        metavar="PATTERN",
        help="Glob patterns of files or folders to exclude (e.g. -e 'test/*' '*.gen.dart')",
    )
    parser.add_argument(
        "--no-ignore",
        action="store_true",
        help="Do not use default ignore lists for build/cache/IDE folders",
    )
    parser.add_argument(
        "--no-gitignore",
        action="store_true",
        help="Do not parse or respect .gitignore file rules",
    )
    parser.add_argument(
        "--markdown",
        action="store_true",
        help="Output as GitHub Flavored Markdown table",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Output as structured JSON",
    )
    parser.add_argument(
        "--csv",
        action="store_true",
        help="Output language breakdown as CSV",
    )
    parser.add_argument(
        "--no-color",
        action="store_true",
        help="Disable colored terminal output",
    )
    parser.add_argument(
        "-v", "--version",
        action="version",
        version=f"%(prog)s {__version__}",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_arguments()

    # Determine target directory
    raw_path = args.path
    if raw_path is None:
        # Check if stdin is interactive terminal or piped
        if sys.stdin.isatty():
            try:
                user_input = input("Enter project directory path [default: .]: ").strip()
                target_path = Path(user_input) if user_input else Path(".")
            except (KeyboardInterrupt, EOFError):
                print("\nAborted.")
                sys.exit(0)
        else:
            target_path = Path(".")
    else:
        target_path = Path(raw_path)

    if not target_path.exists():
        print(f"Error: Path '{target_path}' does not exist.", file=sys.stderr)
        sys.exit(1)

    if not target_path.is_dir():
        print(f"Error: Path '{target_path}' is not a directory.", file=sys.stderr)
        sys.exit(1)

    # Scan the project
    include_set = set(args.include) if args.include else None
    stats = scan_project(
        project_path=target_path,
        include_exts=include_set,
        exclude_patterns=args.exclude,
        use_default_ignore=not args.no_ignore,
        use_gitignore=not args.no_gitignore,
    )

    # Output according to format flags
    if args.json:
        print(render_json(stats))
    elif args.csv:
        print(render_csv(stats))
    elif args.markdown:
        print(render_markdown_table(stats, show_top=args.top))
    else:
        use_color = (not args.no_color) and sys.stdout.isatty()
        # By default, if user didn't specify --top, give them top 5 files if project has >= 5 files to make it informative!
        top_count = args.top if args.top > 0 else (5 if stats.total_files >= 5 else 0)
        output = render_terminal_table(
            stats,
            color=use_color,
            show_top=top_count,
            by_dir=args.by_dir,
            dir_depth=args.dir_depth,
            by_file=args.by_file,
        )
        print(output)


if __name__ == "__main__":
    main()