# 06 — Reglas de Negocio (Alternas / Excepción)

Reglas **alternas** (`RNA-###`): rigen los flujos de excepción, errores y caminos no felices. Complementan las [reglas principales](reglas-principales.md) y alimentan los [flujos alternos](../07-casos-uso/flujos-alternos.md) y los casos de prueba negativos.

---

## Identidad y acceso

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-001 | Correo ya registrado | Registro con correo existente | Rechazo con mensaje genérico; no se revela si el correo existe (anti-enumeración). |
| RNA-002 | Login sin verificar correo | Cuenta no verificada intenta login | Acceso denegado (403); se ofrece reenviar verificación. |
| RNA-003 | Exceso de intentos de login | > 5 intentos fallidos en 15 min por IP/cuenta | Bloqueo temporal (429) por 15 min; se audita. |
| RNA-004 | Token de verificación expirado | Enlace de confirmación caduco | Se invalida y se permite solicitar uno nuevo. |
| RNA-005 | Refresh token de sesión expulsada | Dispositivo previo intenta renovar tras login en otro | Renovación rechazada; exige re-login (refuerza [RN-031](reglas-principales.md)). |
| RNA-006 | MFA fallido | Segundo factor inválido | Acceso denegado aun con contraseña correcta; cuenta el intento. |
| RNA-007 | Inactividad prolongada | 10 min sin interacción del usuario | Aviso al minuto 9 ([MSG-029](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02)); si no responde, cierre automático y re-login ([RN-035/036](reglas-principales.md#control-de-sesiones)). |

## Suscripción y pagos

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-010 | Pago rechazado | Pasarela devuelve fallo | No se activa suscripción; se informa al alumno y se permite reintento. |
| RNA-011 | Webhook duplicado | Pasarela reenvía el mismo evento | Procesamiento idempotente: sin doble vigencia ni doble beneficio (refuerza [RN-021](reglas-principales.md)). |
| RNA-012 | SPEI no acreditado | Referencia generada sin pago | La suscripción permanece inactiva hasta confirmación; la referencia puede expirar. |
| RNA-013 | Acceso con suscripción vencida | Alumno vencido abre contenido | Redirección a renovación; perfil/historial intactos ([RN-015](reglas-principales.md)). |
| RNA-014 | Webhook fuera de orden | Llega "confirmado" después de "reembolsado" | Se respeta el estado final por marca de tiempo; se audita la anomalía. |
| RNA-015 | Reembolso de suscripción activa | Pasarela notifica reembolso | Se suspende el acceso y se marca la suscripción como cancelada. |

## Catálogo y carga masiva

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-020 | Pregunta inválida | < 4 opciones o sin respuesta correcta | Se bloquea la publicación e indica el campo faltante ([RN-004](reglas-principales.md)). |
| RNA-021 | Excel con filas erróneas | Carga masiva parcialmente inválida | Importa las válidas; reporta error por fila; no aborta el lote ([RN-006](reglas-principales.md)). |
| RNA-022 | Excel con formato no soportado | Archivo ilegible/columnas faltantes | Rechazo total con detalle del formato esperado. |
| RNA-023 | Borrado de contenido con historial | Intento de eliminar tema con intentos | Se fuerza borrado lógico, no físico ([RN-006](reglas-principales.md)). |

## Evaluaciones

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-030 | Tiempo agotado en simulador | Vence el temporizador | Cierre automático; se califica lo respondido ([RN-051](reglas-principales.md)). |
| RNA-031 | Pérdida de conexión a mitad del examen | Cliente se desconecta | Se conserva el progreso del intento; al reconectar puede reanudar si la config lo permite. |
| RNA-032 | Tema sin preguntas suficientes | Config pide N > preguntas activas | Se arma con las disponibles y se avisa, o se bloquea el inicio según política. |
| RNA-033 | Doble envío del intento | Reenvío del mismo intento | Idempotencia por intento; no se duplica la calificación ([RN-052](reglas-principales.md)). |

## Referidos

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-040 | Auto-referido | Alumno usa su propio código | Rechazo ([RN-044](reglas-principales.md)). |
| RNA-041 | Exceso de referidos | 4º referido efectivo | No se otorga beneficio adicional ([RN-040](reglas-principales.md)). |
| RNA-042 | Código inexistente/expirado | Registro con código inválido | Se permite el registro pero sin vínculo de referido. |
| RNA-043 | Referido que no paga | Invitado se registra pero no compra | No es referido efectivo; no se otorga beneficio ([RN-041](reglas-principales.md)). |

## Protección de contenido y seguridad

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-050 | URL de medio caducada | Enlace firmado abierto tras expiración | Acceso denegado; se exige nueva URL desde sesión válida. |
| RNA-051 | Acceso a medio sin sesión | Petición directa al recurso | Rechazo; los medios solo se sirven a sesiones autenticadas y vigentes. |
| RNA-052 | Captura en Android | Intento de screenshot en vista protegida | Bloqueo por `FLAG_SECURE`; **no** se puede impedir foto externa ([RN-062](reglas-principales.md)). |
| RNA-053 | Patrón de scraping | Volumen anómalo de peticiones a contenido | Rate limiting + alerta; posible suspensión por abuso. |
| RNA-054 | Disuasor de navegador | Clic derecho / F12-DevTools / arrastrar o guardar imagen sobre contenido protegido | Se intercepta el gesto y se muestra aviso de contenido protegido ([MSG-071/072](../14-mensajes-sistema/mensajes-sistema.md#msg-07x--material-y-protección-de-contenido-mod-07)). Es **disuasión**, no bloqueo garantizable: la inspección del HTML recibido por el navegador no puede impedirse al 100% ([RN-110-07/10](../05-requerimientos/RF-110-proteccion-contenido.md)). |

## Anuncios

| ID | Regla alterna | Disparador | Acción del sistema |
|----|---------------|------------|--------------------|
| RNA-060 | Anuncio fuera de vigencia | Alumno entra con un anuncio ya expirado/programado | No se muestra; solo anuncios `publicados` y vigentes ([RN-120-02](reglas-principales.md#anuncios)). |
| RNA-061 | Audiencia no coincide | Anuncio segmentado no aplica al alumno | Se omite para ese alumno; se muestra solo a la audiencia configurada ([RN-120-02](reglas-principales.md#anuncios)). |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/06-reglas-negocio/reglas-alternas.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
