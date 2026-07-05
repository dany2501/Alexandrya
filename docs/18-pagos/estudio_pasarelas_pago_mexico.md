# Estudio de Pasarelas de Pago para E-commerce en México

## Introducción
El mercado del comercio electrónico en México ha experimentado un crecimiento acelerado en los últimos años, impulsado por una mayor confianza del consumidor y la digitalización de los servicios financieros. Para cualquier modelo de negocio basado en internet —especialmente aquellos que operan bajo esquemas de **suscripciones o cobros recurrentes**— la elección de la pasarela de pago es una decisión estratégica crítica. Esta elección influye de manera directa en la tasa de conversión del carrito de compra, el costo operativo por transacción y la carga administrativa de conciliación fiscal.

El presente documento analiza las cinco principales pasarelas de pago operativas en el país (Conekta, Stripe, Clip, Mercado Pago y PayPal), ordenadas de menor a mayor costo de comisión estándar para tarjetas nacionales. Asimismo, se incluye un desglose financiero y fiscal enfocado en un modelo de cobro de **suscripción semestral de $2,500.00 MXN**, evaluando el impacto real de las comisiones y los impuestos obligatorios vigentes en México (IVA e ISR).

---

## Resumen Detallado de Pasarelas de Pago

### 1. Conekta (La opción local optimizada)
Es una pasarela de origen mexicano diseñada específicamente para resolver las particularidades del mercado local. Destaca por su excelente manejo y conciliación de pagos en efectivo a través de redes de tiendas de conveniencia y transferencias interbancarias.
* **Integración:** Ofrece una API RESTful robusta para integraciones personalizadas *server-to-server*, componentes visuales ya creados (*Conekta Components*) que permiten incrustar formularios seguros mediante iFrames para mantener el cumplimiento PCI-DSS, y plugins listos para CMS populares (Shopify, WooCommerce, Magento).
* **Restricciones:** Requiere de manera obligatoria contar con un RFC mexicano válido (Persona Física con Actividad Empresarial o Persona Moral). Su infraestructura y soporte para transacciones internacionales o multi-divisa son más limitados en comparación con proveedores globales.

### 2. Stripe (El estándar de infraestructura técnica)
Es la plataforma global de procesamiento de pagos de referencia para desarrolladores y startups tecnológicas debido a la elegancia y documentación de su arquitectura de software. Su ecosistema de prevención de fraude (*Stripe Radar*) utiliza aprendizaje automático avanzado.
* **Integración:** Proporciona un alto abanico de opciones: *Stripe Elements* (componentes de UI modulares y sumamente personalizables), *Stripe Checkout* (redireccionamiento a una página de pago alojada y optimizada al 100% por Stripe) y una API nativa de bajo nivel para flujos de trabajo hiper-personalizados. Cuenta con la herramienta *Stripe Billing* especializada en suscripciones complejas.
* **Restricciones:** El monitoreo de contracargos es sumamente automatizado y estricto; tasas elevadas de disputas pueden congelar o suspender la cuenta sin previo aviso. Los flujos para pagos en efectivo locales no son tan nativos o fluidos como en las opciones locales.

### 3. Clip - Versión Online (Simplicidad sin cuotas fijas)
Reconocido ampliamente en México por democratizar las terminales físicas (mPOS), Clip extendió su suite hacia el comercio electrónico con un modelo comercial simplificado dirigido a micro y medianas empresas que buscan evitar costos fijos.
* **Integración:** Enfocado en la baja fricción técnica. Permite generar enlaces de pago de manera directa desde su aplicación o panel de control (ideal para flujos manuales o redes sociales), cuenta con plugins de rápida instalación para WooCommerce y Shopify, y una API básica para el desarrollo de checkouts directos.
* **Restricciones:** Carece de herramientas nativas avanzadas para la administración de modelos de suscripción automatizados, lógica de cobros recurrentes o estructuras de *split payouts* para marketplaces.

### 4. Mercado Pago (El ecosistema líder en conversión regional)
La división fintech de Mercado Libre se ha consolidado como la pasarela con mayor tasa de aprobación y familiaridad en América Latina. La gran ventaja competitiva radica en que millones de usuarios ya tienen la aplicación instalada con tarjetas guardadas o saldo disponible.
* **Integración:** Dispone de *Checkout Pro*, el cual redirige temporalmente al usuario a la interfaz segura de Mercado Pago permitiendo pagar con saldo en billetera, dinero a crédito (*Mercado Crédito*) o efectivo. También ofrece *Checkout API* para una integración transparente integrada al sitio web, y módulos en un clic para las principales plataformas de e-commerce.
* **Restricciones:** Es conocida por aplicar políticas estrictas y retenciones preventivas de saldos a ciertos giros comerciales considerados de riesgo (como dropshipping o suplementos alimenticios). Su costo fijo por transacción penaliza gravemente los tickets de bajo valor unitario.

### 5. PayPal (Confianza del consumidor con costo premium)
Es el pionero global de los pagos digitales. Incluirlo como método secundario en un e-commerce en México es crucial para mitigar el abandono de carrito, ya que el usuario final confía plenamente en su programa de Protección al Comprador y evita ingresar los datos de su tarjeta en sitios externos.
* **Integración:** Principalmente implementado a través de los *Smart Payment Buttons* (componentes de JavaScript oficiales que se renderizan directamente en la página de pago) o redireccionando al cliente hacia una ventana emergente segura administrada por PayPal.
* **Restricciones:** Es la pasarela comercial más costosa del ecosistema. El flujo de usuario habitualmente obliga o incentiva fuertemente al cliente a abrir o iniciar sesión en una cuenta PayPal, lo cual añade pasos al checkout si no cuenta con una. Los fondos pueden demorar de 1 a 3 días hábiles en ser transferidos a una cuenta bancaria de México de forma automatizada.

---

## Tabla Comparativa de Pasarelas

| Pasarela de Pago | Comisión Porcentaje | Cuota Fija (MXN) | Método de Integración Principal | Ideal para... |
| :--- | :---: | :---: | :--- | :--- |
| **1. Conekta** | 3.40% | $3.00 | API REST / Componentes iFrame | Negocios locales con fuerte volumen en SPEI y OXXO |
| **2. Stripe** | 3.60% | $3.00 | Stripe Elements / Stripe Checkout | SaaS, Startups y modelos de suscripciones escalables |
| **3. Clip (Online)** | 3.60% | $0.00 | Enlaces de Pago / Plugins CMS | Microempresas y negocios con tickets muy bajos |
| **4. Mercado Pago**| 3.49% | $4.00 | Checkout Pro (Redirección) / API | E-commerce B2C buscando aprovechar su billetera digital |
| **5. PayPal** | 3.95% | $4.00 | Smart Payment Buttons / Redirección | Pasarela alternativa para infundir confianza y seguridad |

*Nota: Las comisiones expresadas en la tabla corresponden a tarifas estándar públicas para procesamiento de tarjetas de crédito/débito nacionales y no incluyen el 16% de IVA operativo.*

---

## Análisis Financiero: Caso Práctico (Suscripción Semestral de $2,500.00 MXN)

A continuación, se detalla el impacto económico de procesar un cargo único de **$2,500.00 MXN cada 6 meses**. Se asume el uso de **Conekta** (por ser la opción de menor comisión para procesamiento de tarjetas nacionales) y que el negocio opera bajo el régimen fiscal de **RESICO** (Régimen Simplificado de Confianza - Persona Física), el cual es el esquema óptimo para emprendedores en México.

### 1. Desglose de Comisiones de la Pasarela
Al realizarse un solo cargo semestral, la tarifa fija de la pasarela solo se aplica una vez cada seis meses, eficientando el costo por transacción:

* **Monto del Cargo Semestral:** $2,500.00 MXN
* **Comisión de Procesamiento Base (3.4% + $3.00 MXN):**
  * Parcial porcentual: `$2,500.00 * 0.034 = $85.00 MXN`
  * Tarifa fija: `$3.00 MXN`
  * Subtotal de Comisión: `$85.00 + $3.00 = $88.00 MXN`
* **IVA de la Comisión (16% requerido por ley):** `$88.00 * 0.16 = $14.08 MXN`
* **Total Retenido por la Pasarela:** **$102.08 MXN**

*Monto neto depositado en banco por cada renovación:* **$2,397.92 MXN**

### 2. Desglose Fiscal e Impuestos (SAT)
Considerando que el precio al público de la suscripción ($2,500.00 MXN) ya integra los impuestos correspondientes para evitar fricciones comerciales:

* **Separación de IVA (16%):**
  * Subtotal real del servicio / ingreso bruto: `$2,500.00 / 1.16 = $2,155.17 MXN`
  * IVA Recaudado (a entregar al SAT): `$2,500.00 - $2,155.17 = $344.83 MXN`
  *(Nota: El negocio puede acreditar el IVA de la comisión de Conekta —$14.08 MXN— contra este monto en su declaración mensual).*

* **Cálculo de ISR (Régimen RESICO - Tasa del 2.5%):**
  * El ISR se calcula de forma directa sobre el ingreso bruto acumulado sin IVA: `$2,155.17 * 0.025 = $53.88 MXN`

### 3. Balance Semestral Neto por Suscriptor

| Concepto Financiero | Impacto Económico | Porcentaje sobre Total |
| :--- | :---: | :---: |
| **Precio Pagado por el Usuario** | **$2,500.00 MXN** | **100.00%** |
| Menos: Comisión Total de Pasarela (Conekta + IVA) | - $102.08 MXN | 4.08% |
| Menos: Impuesto al Valor Agregado (IVA) al SAT | - $344.83 MXN | 13.79% |
| Menos: Impuesto Sobre la Renta (ISR - RESICO) | - $53.88 MXN | 2.16% |
| **Utilidad Neta Real para la Empresa** | **$1,999.21 MXN** | **79.97%** |
