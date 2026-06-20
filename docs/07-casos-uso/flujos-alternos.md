# 07 — Flujos Alternos

Catálogo de flujos alternos y de excepción (`FA-###`). Cada flujo describe una desviación del camino feliz, su disparador, los pasos y la regla alterna ([`RNA`](../06-reglas-negocio/reglas-alternas.md)) que lo gobierna.

---

## Convención

| Campo | Significado |
|-------|-------------|
| **Origen** | Caso de uso y paso del flujo principal donde se bifurca. |
| **Disparador** | Condición que activa el flujo alterno. |
| **Regla** | `RNA-###` asociada. |
| **Resultado** | Estado al que conduce. |

---

## Identidad y acceso (CU-001 / CU-002 / CU-003)

### FA-001 — Credenciales inválidas
- **Origen:** CU-001, paso "validar credenciales".
- **Disparador:** contraseña incorrecta.
- **Pasos:** 1) Sistema no encuentra coincidencia de hash. 2) Incrementa contador de intentos. 3) Audita el fallo. 4) Muestra "Credenciales inválidas" con intentos restantes.
- **Regla:** RNA-006 / RN-001A-02 · **Resultado:** permanece en login.

### FA-002 — Correo no verificado
- **Disparador:** la cuenta existe pero no está verificada.
- **Pasos:** 1) Sistema detecta `email_verificado = false`. 2) Deniega acceso (403). 3) Ofrece reenviar verificación.
- **Regla:** RNA-002 · **Resultado:** pantalla de verificación pendiente.

### FA-003 — Bloqueo por rate limiting
- **Disparador:** > 5 intentos fallidos en 15 min.
- **Pasos:** 1) Sistema bloquea (429). 2) Inicia ventana de 15 min. 3) Muestra cuenta regresiva.
- **Regla:** RNA-003 · **Resultado:** acceso bloqueado temporalmente.

### FA-004 — Expulsión por sesión única
- **Origen:** CU-001 con sesión previa activa.
- **Disparador:** login exitoso en un nuevo dispositivo.
- **Pasos:** 1) Sistema invalida la sesión anterior. 2) El dispositivo viejo recibe 401 al siguiente request. 3) Se notifica el nuevo acceso por correo.
- **Regla:** RN-031, RNA-005 · **Resultado:** una sola sesión activa.

---

## Suscripción y pagos (CU-020 / CU-021)

### FA-010 — Pago rechazado
- **Disparador:** la pasarela devuelve fallo.
- **Pasos:** 1) No se activa la suscripción. 2) Se informa el motivo. 3) Se permite reintentar con otro método.
- **Regla:** RNA-010 · **Resultado:** suscripción inactiva, reintento disponible.

### FA-011 — SPEI pendiente de acreditación
- **Disparador:** se genera referencia pero no llega confirmación.
- **Pasos:** 1) Suscripción queda en "pendiente". 2) Acceso bloqueado. 3) Al recibir webhook de acreditación se activa.
- **Regla:** RNA-012 · **Resultado:** activación diferida.

### FA-012 — Webhook duplicado
- **Disparador:** la pasarela reenvía el mismo evento.
- **Pasos:** 1) Sistema detecta `payload_hash` ya procesado. 2) Ignora el duplicado. 3) No altera la vigencia.
- **Regla:** RNA-011 · **Resultado:** sin doble cobro de vigencia.

### FA-013 — Acceso con suscripción vencida
- **Disparador:** alumno vencido abre contenido.
- **Pasos:** 1) Sistema verifica estado. 2) Redirige a renovación. 3) Conserva perfil e historial.
- **Regla:** RNA-013 · **Resultado:** invitación a renovar.

---

## Catálogo y carga masiva (CU-030 / CU-031)

### FA-020 — Excel con filas inválidas
- **Disparador:** algunas filas no cumplen el formato.
- **Pasos:** 1) Sistema valida fila por fila. 2) Importa válidas. 3) Genera reporte de errores descargable.
- **Regla:** RNA-021 · **Resultado:** importación parcial con reporte.

### FA-021 — Pregunta incompleta
- **Disparador:** intento de publicar pregunta sin respuesta correcta o ≠4 opciones.
- **Pasos:** 1) Validación bloquea. 2) Resalta el campo faltante.
- **Regla:** RNA-020 · **Resultado:** pregunta queda en borrador.

---

## Evaluaciones (CU-040 / CU-041)

### FA-030 — Tiempo agotado en simulador
- **Disparador:** vence el temporizador.
- **Pasos:** 1) Cierre automático del intento. 2) Califica lo respondido. 3) Muestra resultado.
- **Regla:** RNA-030 · **Resultado:** intento calificado parcial.

### FA-031 — Desconexión durante el examen
- **Disparador:** pérdida de red.
- **Pasos:** 1) Cliente guarda progreso local. 2) Al reconectar, sincroniza. 3) Reanuda si la config lo permite.
- **Regla:** RNA-031 · **Resultado:** continuidad del intento.

---

## Referidos (CU-070)

### FA-040 — Auto-referido
- **Disparador:** alumno usa su propio código.
- **Pasos:** 1) Sistema detecta coincidencia de titular. 2) Rechaza el vínculo.
- **Regla:** RNA-040 · **Resultado:** sin beneficio.

### FA-041 — Límite de referidos excedido
- **Disparador:** 4º referido efectivo.
- **Pasos:** 1) Sistema cuenta referidos efectivos. 2) No otorga beneficio adicional.
- **Regla:** RNA-041 · **Resultado:** beneficio limitado a 3.

---

## Material y medios (CU-060)

### FA-050 — URL de medio caducada
- **Disparador:** enlace firmado abierto tras expirar.
- **Pasos:** 1) Backend rechaza. 2) Cliente solicita URL nueva desde sesión válida.
- **Regla:** RNA-050 · **Resultado:** re-emisión de URL.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/07-casos-uso/flujos-alternos.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
