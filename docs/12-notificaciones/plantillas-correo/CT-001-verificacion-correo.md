# CT-001 — Verificación de correo

| Campo | Valor |
|-------|-------|
| **Notificación** | NT-001 |
| **Disparador** | Registro exitoso (RF-011) |
| **Destinatario** | Alumno recién registrado |
| **Prioridad** | Alta |
| **Token** | Verificación, un solo uso, expira en 24 h |

**Asunto:** Confirma tu cuenta en Alexandrya

**Cuerpo:**
```
Hola {{nombre}},

¡Bienvenido a Alexandrya! Para activar tu cuenta y empezar a prepararte,
confirma tu correo dando clic en el siguiente botón:

        [ Confirmar mi cuenta ]
        {{enlace_accion}}

Este enlace expira en 24 horas. Si no creaste esta cuenta, ignora este correo.

— Equipo Alexandrya
```

**Variables:** `{{nombre}}`, `{{enlace_accion}}`.
**Notas:** sin contraseñas ni tokens visibles en texto plano más allá del enlace de un solo uso ([RN-071](../../06-reglas-negocio/reglas-principales.md)).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/12-notificaciones/plantillas-correo/CT-001-verificacion-correo.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../../README.md) · 💬 [Mensajes del sistema](../../14-mensajes-sistema/mensajes-sistema.md)</sub>
