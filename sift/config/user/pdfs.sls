{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

{%-
set pdfs = [
  {
    "id": "poster-threat-intelligence",
    "filename": "Poster_Threat-Intelligence-Consumption.pdf",
    "source": "https://www.sans.org/security-resources/posters/cyber-threat-intelligence-consumption/130/download",
    "hash": "02f71ad97ece95e9bea61db31fe026b7b6c7e04a2a1f3257b51ace3153e88d59",
  },
  {
    "id": "poster-network-forensics",
    "filename": "Network-Forensics-Poster.pdf",
    "source": "https://digital-forensics.sans.org/media/Poster_Network-Forensics_WEB.pdf",
    "hash": "5ae5487f9555ef03d540c9f0939d0a5c29c4c080fd91d3336fc97dee47a2bd86",
  },
  {
    "id": "dfir-thread-intel-poster",
    "filename": "DFIR-Threat-Intel-Poster.pdf",
    "source": "https://digital-forensics.sans.org/media/Poster_DFIR_Threat-Intel_2017.pdf",
    "hash": "e221bc427061602c29a1b1250ee76e3f3adb4aace5ff4f41e1d3918ad6d9abb4"
  },
  {
    "id": "poster-sift-remnux",
    "filename": "SIFT-REMnux-Poster.pdf",
    "source": "https://digital-forensics.sans.org/media/Poster_SIFT_REMnux_2016_FINAL.pdf",
    "hash": "7c63107152e3a1b63500c3294f3a760a89c1ea504d9100c72d28727321ef63c3"
  },
  {
    "id": "poster-cheatsheet-rekall",
    "filename": "Rekall-Cheatsheet.pdf",
    "source": "https://digital-forensics.sans.org/media/rekall-memory-forensics-cheatsheet.pdf",
    "hash": "6b30c6f51b73b17b0e719a7a47cf5ba140cfc13afb96f1feb3b77c31345aceb2"
  },
  {
    "id": "poster-dfir-smartphone",
    "filename": "DFIR-Smartphone-Forensics-Poster.pdf",
    "source": "https://digital-forensics.sans.org/media/DFIR-Smartphone-Forensics-Poster.pdf",
    "hash": "1b2d79a2abb9d2122f77e682a61bc5b85ae2e5f58e846c49424080226e50d393"
  },
  {
    "id": "poster-windows-forensics",
    "filename": "Windows-Forensics-Poster.pdf",
    "source": "https://digital-forensics.sans.org/media/Poster_Windows_Forensics_2017_WEB.pdf",
    "hash": "4b625889deb5f98fd852b85d99882d794a5fa8a58a0c33e925970c93ff4e739c"
  },
  {
    "id": "poster-find-evil",
    "filename": "Find-Evil.pdf",
    "source": "https://digital-forensics.sans.org/media/Poster_2016_Find_Evil.pdf",
    "hash": "d38b39637ae5ebf0d40dcd676be1c9410f91ed1c047c59a27c0c488ae570920f"
  },
  {
    "id": "cheatsheet-sift",
    "filename": "SIFT-Cheatsheet.pdf",
    "source": "https://digital-forensics.sans.org/media/sift_cheat_sheet.pdf",
    "hash": "8fda96c8f7bc32844b843dd3d95e793316e23b765b440b240681d3bc9724ad5c"
  },
  {
    "id": "guide-linux-shell-survival",
    "filename": "Linux-Shell-Survival-Guide.pdf",
    "source": "https://digital-forensics.sans.org/media/linux-shell-survival-guide.pdf",
    "hash": "15a731e1f55643ccb909c84fe4b8d8d35b0dd5de4cb0588aeca0b38f8a917ace"
  },
  {
    "id": "cheatsheet-windows-to-unix",
    "filename": "Windows-to-Unix-Cheatsheet.pdf",
    "source": "https://digital-forensics.sans.org/media/windows_to_unix_cheatsheet.pdf",
    "hash": "97be37ea175c0f53a808c45fcbeacd11889d77a566d2a01d421865bb4c352312"
  },
  {
    "id": "cheatsheet-volatility",
    "filename": "Volatility-Cheatsheet.pdf",
    "source": "https://digital-forensics.sans.org/media/volatility-memory-forensics-cheat-sheet.pdf",
    "hash": "699ea76d1713074fe0d32eaad437f3b2c7e089ae8d00e5d43aa97cc81ed0f44f"
  },
  {
    "id": "cheatsheet-hexfile-regex",
    "filename": "Hex-File-Regex-Cheatsheet.pdf",
    "source": "https://digital-forensics.sans.org/media/hex_file_and_regex_cheat_sheet.pdf",
    "hash": "d1a78b37886f524bc94e3e3aac8ab9816e904a6583f0145fd26c67524e23d032"
  },
]
-%}

include:
  - sift.config.user.user

{% for pdf in pdfs %}
sift-pdf-{{ pdf.id }}:
  file.managed:
    - name: {{ home }}/Desktop/{{ pdf.filename }}
    - source: {{ pdf.source }}
    - source_hash: sha256={{ pdf.hash }}
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - show_changes: False
    - require:
      - user: sift-user-{{ user }}
{% endfor %}
