# /improve

Verilen içeriği (video, makale, fikir, metin) sistemi geliştirme fırsatı olarak analiz eder.

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

## Onay sonrası

Kullanıcı "yap" derse → doğrudan implement et.
Uygulanan pattern'ı kaydet:
```bash
bash ~/.claude/plugins/improve/scripts/save-pattern.sh "[isim]" "[kategori]" "[açıklama]"
```
