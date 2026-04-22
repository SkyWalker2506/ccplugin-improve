# /improve

Analyze content (video, article, idea, text, URL) as a system improvement opportunity — or list/search saved patterns.

## Subcommands

| Subcommand | Description |
|------------|-------------|
| `/improve [content]` | Analyze content and suggest improvements |
| `/improve list` | List all saved patterns |
| `/improve list --category <type>` | Filter by category (skill/agent/plugin/memory/config/workflow) |
| `/improve list --search <term>` | Search patterns by keyword |
| `/improve watch [dir]` | Start watch mode on a directory |

## Sistem context'i yükle

```bash
bash ~/.claude/plugins/improve/scripts/read-context.sh
```

Yukarıdaki çıktıyı analiz bağlamı olarak kullan.

## Analiz

Argümanı veya kullanıcının verdiği içeriği şu kategorilere göre değerlendir:

| Kategori | Soru |
|----------|------|
| **Skill** | Bu bir skill olabilir mi? |
| **Agent** | Hangi agent'a capability ekler? |
| **Plugin** | Ayrı ccplugin gerektirir mi? |
| **Memory** | Kalıcı kural/davranış ekler mi? |
| **Config** | settings.json / install.sh değişikliği mi? |
| **Workflow** | Mevcut akışı iyileştirir mi? |

## Çıktı formatı

```
## 🔍 İçerik Özeti
[1-2 cümle]

## ✅ Sisteme Uygulanabilirler
- **[Başlık]** — [ne yapılır, nereye eklenir]
  Öncelik: yüksek / orta / düşük | Efor: quick / medium / long

## ❌ Uygun Olmayanlar
[Neden — kısa]

## 🚀 Hemen Yapılabilecek
[Uygulayayım mı? diye sor]
```

## /improve list

When the argument is `list`:

```bash
bash ~/.claude/plugins/improve/scripts/list-patterns.sh [--category <type>] [--search <term>]
```

Show the output to the user as a formatted table.

## After approval

If user says "do it" → implement directly.
Save the applied pattern:
```bash
bash ~/.claude/plugins/improve/scripts/save-pattern.sh "[name]" "[category]" "[description]"
# Add --force to overwrite an existing pattern with the same name
```

## URL / Video content

If the argument starts with `http://` or `https://`:
- Fetch the content using the available fetch tool (fetch_readable or fetch_youtube_transcript for YouTube URLs)
- Use the fetched content as the analysis input
- Summarize the source URL in the output
