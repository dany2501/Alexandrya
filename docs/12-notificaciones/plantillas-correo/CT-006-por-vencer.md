# CT-006 — Suscripción próxima a vencer

| Campo | Valor |
|-------|-------|
| **Notificación** | NT-006 |
| **Disparador** | Job de vigencias; ventana configurable (ej.: 15 y 3 días antes) (RF-026) |
| **Destinatario** | Alumno con suscripción activa por vencer |
| **Prioridad** | Alta |

**Asunto:** Tu suscripción a Alexandrya vence en {{dias_restantes}} días

**Cuerpo:**
```
Hola {{nombre}},

Tu suscripción está por terminar:

  • Vence: {{fin_vigencia}}
  • Días restantes: {{dias_restantes}}

Renueva antes del vencimiento y no pierdas días: tu nueva vigencia
se suma a la actual.

        [ Renovar ahora ]

Si renuevas después del vencimiento, iniciará un nuevo periodo de 1 año.

— Equipo Alexandrya
```

**Variables:** `{{nombre}}`, `{{fin_vigencia}}`, `{{dias_restantes}}`.
**Regla relacionada:** renovación anticipada extiende sin perder días ([RN-013](../../06-reglas-negocio/reglas-principales.md)).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/12-notificaciones/plantillas-correo/CT-006-por-vencer.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../../README.md) · 💬 [Mensajes del sistema](../../14-mensajes-sistema/mensajes-sistema.md)</sub>
