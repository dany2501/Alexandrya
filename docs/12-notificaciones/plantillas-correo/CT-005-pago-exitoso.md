# CT-005 — Pago exitoso

| Campo | Valor |
|-------|-------|
| **Notificación** | NT-005 |
| **Disparador** | Webhook de pago confirmado (RF-090, RN-020) |
| **Destinatario** | Alumno |
| **Prioridad** | Alta |

**Asunto:** ¡Pago confirmado! Tu suscripción a Alexandrya está activa

**Cuerpo:**
```
Hola {{nombre}},

Recibimos tu pago y tu suscripción ya está activa. ¡A estudiar!

  • Monto: {{monto}} MXN
  • Método: {{metodo}}
  • Folio: {{folio}}
  • Vigencia hasta: {{fin_vigencia}}

Accede a todas las materias, simuladores y tu dashboard de progreso:
        [ Entrar a Alexandrya ]

Gracias por confiar en nosotros.
— Equipo Alexandrya
```

**Variables:** `{{nombre}}`, `{{monto}}`, `{{metodo}}`, `{{folio}}`, `{{fin_vigencia}}`.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/12-notificaciones/plantillas-correo/CT-005-pago-exitoso.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../../README.md) · 💬 [Mensajes del sistema](../../14-mensajes-sistema/mensajes-sistema.md)</sub>
