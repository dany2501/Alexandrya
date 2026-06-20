# CT-002 — Aviso de nuevo acceso

| Campo | Valor |
|-------|-------|
| **Notificación** | NT-002 |
| **Disparador** | Inicio de sesión (RF-083, RN-034) |
| **Destinatario** | Titular de la cuenta |
| **Prioridad** | Media |

**Asunto:** Nuevo inicio de sesión en tu cuenta Alexandrya

**Cuerpo:**
```
Hola {{nombre}},

Detectamos un inicio de sesión en tu cuenta:

  • Fecha y hora: {{fecha}} {{hora}}
  • Dispositivo: {{dispositivo}}
  • IP: {{ip}}
  • Ubicación aproximada: {{ubicacion}}

Recuerda: por seguridad, solo puede haber una sesión activa a la vez.
Si fuiste tú, no necesitas hacer nada.

Si NO reconoces este acceso, cambia tu contraseña de inmediato:
        [ Cambiar contraseña ]
        {{enlace_accion}}

— Equipo Alexandrya
```

**Variables:** `{{nombre}}`, `{{fecha}}`, `{{hora}}`, `{{dispositivo}}`, `{{ip}}`, `{{ubicacion}}`, `{{enlace_accion}}`.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/12-notificaciones/plantillas-correo/CT-002-aviso-acceso.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../../README.md) · 💬 [Mensajes del sistema](../../14-mensajes-sistema/mensajes-sistema.md)</sub>
