---
name: go-code-review
description: Go code review skill synthesized from 4,100+ PR review comments spanning 4.5 years from the tetrateio/tetrate repository. Use this skill when reviewing Go code, providing code review feedback, or understanding common review patterns. Contains patterns for error handling, nesting reduction, thread safety, testing, naming, interface design, and more.
---

# Go Code Review Patterns

This skill provides Go code review patterns synthesized from **4,100+ actual PR review comments** spanning 4.5 years. These patterns represent real-world feedback from experienced Go engineers reviewing production code in a large monorepo.

## Pattern Frequency Analysis

Based on analysis of 16,427 Go-specific review comments:
- **Testing patterns**: 3,875 comments (24%)
- **Proto/gRPC patterns**: 2,417 comments (15%)
- **Code suggestions**: 1,930 comments (12%)
- **Naming patterns**: 1,165 comments (7%)
- **Error handling**: 1,127 comments (7%)
- **Code simplification**: 1,119 comments (7%)
- **Nit comments**: 955 comments (6%)
- **Documentation**: 821 comments (5%)
- **Concurrency**: 674 comments (4%)

---

## Error Handling

### Use Sentinel Errors with errors.Is/As
Create package-level sentinel errors instead of comparing strings:

```go
// Good - sentinel error
var errNoKubeClientAvailable = errors.New("no kubernetes client available")

// In test
require.ErrorIs(t, err, errNoKubeClientAvailable)

// Bad - string comparison (flaky)
if err.Error() == "no kubernetes client available" { ... }
```

**Real review comment:** *"Comparing strings is flaky. Better use constant errors."*

### Error Wrapping Style (Uber Guide)
Follow [Uber's error wrapping guide](https://github.com/uber-go/guide/blob/master/style.md#error-wrapping):

```go
// Good - lowercase, no "failed to" prefix, add context
return fmt.Errorf("get ConfigMap %s/%s: %w", namespace, name, err)
return fmt.Errorf("create user %s: %w", userID, err)

// Bad - generic or redundant prefixes
return fmt.Errorf("failed to process: %w", err)
return fmt.Errorf("error: %w", err)
return fmt.Errorf("unable to connect: %w", err)
```

**Real review comment:** *"nit: avoid 'failed to' https://github.com/uber-go/guide/blob/master/style.md#error-wrapping"*

### Use errors.New for Static Errors
```go
// Good - static error
return nil, errors.New("only UNUSED usage is currently supported")

// Bad - fmt.Errorf without formatting
return nil, fmt.Errorf("only UNUSED usage is currently supported")
```

### Use errors.Join for Multiple Errors
```go
// Good - errors.Join for lists
var errs []error
for _, item := range items {
    if err := validate(item); err != nil {
        errs = append(errs, err)
    }
}
return errors.Join(errs...)

// Bad - excessive wrapping
for _, item := range items {
    if err := validate(item); err != nil {
        allErr = fmt.Errorf("%w; %v", allErr, err)
    }
}
```

**Real review comment:** *"Instead of doing this, declare `var errs []error` and append normally there. Then use `errors.Join` when returning the error."*

### Return Early on Error
```go
// Good - return on error
if err != nil {
    return nil, fmt.Errorf("get config: %w", err)
}
// continue with happy path

// Bad - continue after potential error
if err != nil {
    // log and continue - don't do this!
}
```

---

## Code Simplification

### Reduce Nesting with Early Returns
Apply [Uber style guide nesting reduction](https://github.com/uber-go/guide/blob/master/style.md#reduce-nesting):

```go
// Good - guard clauses
configMap, err := h.GetConfigMap(ctx, namespace, name)
if err == nil {
    return configMap, false, nil
}

if !apierrors.IsNotFound(err) {
    return nil, false, fmt.Errorf("get ConfigMap: %w", err)
}

// continue with creation...

// Bad - deeply nested
if err != nil {
    if apierrors.IsNotFound(err) {
        newConfigMap, createErr := createFn()
        if createErr == nil {
            // ...
        }
    }
}
```

**Real review comment:** *"nit: avoid indent by reversing logic and early continuation"*

### Invert Conditions for Early Return
```go
// Good - invert and return early
if !isValid(input) {
    return errors.New("invalid input")
}
// main logic here

// Bad - unnecessary nesting
if isValid(input) {
    // main logic here
} else {
    return errors.New("invalid input")
}
```

### Use continue in Loops
```go
// Good - early continue
for _, item := range items {
    if item == nil {
        continue
    }
    if !item.IsValid() {
        continue
    }
    process(item)
}

// Bad - nested
for _, item := range items {
    if item != nil {
        if item.IsValid() {
            process(item)
        }
    }
}
```

### Extract Helper Functions for Long Methods
**Real review comment:** *"nit: could you pull this to a helper method? The level of nesting here makes it hard to follow"*

---

## Testing

### Use require Over Manual Checks
```go
// Good
require.NoError(t, err)
require.Equal(t, expected, actual)
require.NotEmpty(t, output)

// Bad
if err != nil {
    t.Fatalf("unexpected error: %v", err)
}
```

**Real review comment:** *"consider using `require.NoError(t, err)` instead, and below"*

### Use require.ErrorIs for Sentinel Errors
```go
// Good - type-safe error checking
require.ErrorIs(t, err, errNotFound)

// Bad - string comparison
require.ErrorContains(t, err, "not found")
```

### Use testdata Folders for Expected Values
```go
// Good - use testdata folder
func TestTranslate(t *testing.T) {
    input := mustReadFile(t, "testdata/input.yaml")
    expected := mustReadFile(t, "testdata/output.yaml")
    actual := translate(input)
    require.YAMLEq(t, expected, actual)
}
```

**Real review comment:** *"let's add proper test assertion files in a `testdata` folder so that we can verify the contents of what's being returned"*

### Use require.JSONEq or require.YAMLEq
```go
// Good - semantic comparison
require.JSONEq(t, expectedJSON, actualJSON)
require.YAMLEq(t, expectedYAML, actualYAML)

// Bad - byte-level comparison
require.Equal(t, []byte(expected), actual)
```

**Real review comment:** *"instead of all this, could you just serialise both actual/expected as JSON or YAML and then do `require.JSONEq` or `YAMLEq`"*

### Avoid Testing Only Mock Behavior
```go
// Bad - only tests mock setup
mock := &MockStore{returnValue: "expected"}
svc := NewService(mock)
result := svc.Get()
require.Equal(t, "expected", result) // Tests nothing real
```

**Real review comment:** *"This indirection layer you're adding is kinda pointless... adding a layer there to mock grpc stuff provides no value"*

### Use embed.FS for Test Data
```go
//go:embed testdata/*.yaml
var testdataFS embed.FS

func TestCases(t *testing.T) {
    entries, _ := testdataFS.ReadDir("testdata")
    for _, e := range entries {
        // ...
    }
}
```

**Real review comment:** *"What about having just one variable with all testdata files and declare it as an `embed.FS`, then in the table test you just pass the name of the files?"*

---

## Concurrency

### Use RWMutex for Read-Heavy Workloads
```go
// Good
type Cache struct {
    mu    sync.RWMutex
    items map[string]Item
}

func (c *Cache) Get(key string) (Item, bool) {
    c.mu.RLock()
    defer c.mu.RUnlock()
    item, ok := c.items[key]
    return item, ok
}

// Bad - using Mutex for reads
func (c *Cache) Get(key string) (Item, bool) {
    c.mu.Lock()
    defer c.mu.Unlock()
    // ...
}
```

**Real review comment:** *"nit: if you change the mu to a RWMutex then you can"*

### Avoid sync.Once Misuse in Tests
```go
// Bad - new instance per test does nothing
func TestFoo(t *testing.T) {
    var once sync.Once  // Different instance each test!
    once.Do(setup)
}
```

**Real review comment:** *"you're using `sync.Once` incorrectly, as you're using a different instance in each test, which does nothing. This is completely wrong."*

### Avoid init() - It's an Anti-Pattern
```go
// Bad - hidden global state mutation
func init() {
    globalConfig = loadConfig()
}

// Good - explicit initialization
func main() {
    config := loadConfig()
    // pass config explicitly
}
```

**Real review comment:** *"`init` is an anti-pattern in tests"*

### Use Pointer Receivers with Mutexes
```go
// Good - pointer receiver prevents struct copy
func (w *Wrapper) Name() string {
    w.mu.RLock()
    defer w.mu.RUnlock()
    return w.name
}

// Bad - value receiver copies mutex (data race!)
func (w Wrapper) Name() string {
    return w.name
}
```

### Document Thread Safety Assumptions
```go
// unsafeConfigRepository bypasses permission checks.
// Safe because this API only allows org-owners to call it.
unsafeConfigRepository persistence.UnsafeConfigRepository
```

---

## Naming Conventions

### Avoid Get Prefix (Effective Go)
Per [Effective Go Getters](https://go.dev/doc/effective_go#Getters):

```go
// Good
func (u *User) Name() string { ... }
func (c *Config) Timeout() time.Duration { ... }

// Bad
func (u *User) GetName() string { ... }
func (c *Config) GetTimeout() time.Duration { ... }
```

**Real review comment:** *"nit: avoid get prefix https://golang.org/doc/effective_go#Getters"*

### Capitalize Initialisms
Per [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments#initialisms):

```go
// Good
var userID string
var xmlAPI string
var httpClient *http.Client

// Bad
var userId string
var xmlApi string
var httpClient *http.Client  // Actually correct, HTTP is initialism
```

**Real review comment:** *"nit: capitalize acronyms https://github.com/golang/go/wiki/CodeReviewComments#initialisms"*

### Use Short Receiver Names
```go
// Good
func (u *User) Name() string { ... }
func (s *Server) Handle(ctx context.Context) { ... }

// Bad
func (user *User) Name() string { ... }
func (server *Server) Handle(ctx context.Context) { ... }
```

### Avoid Underscore Prefixes
Go doesn't use underscore prefixes for scope:

```go
// Good
type Config struct {
    registrationDone bool
}

// Bad - not idiomatic Go
type Config struct {
    _registrationDone bool
}
```

**Real review comment:** *"nit: in Go we don't see this kind of underscore prefixes to hint scope like in other langs"*

### Use Must Prefix for Panicking Functions
```go
// Good - clear panic semantics
func MustCreateDir(path string) {
    if err := os.MkdirAll(path, 0755); err != nil {
        panic(err)
    }
}

// Bad - unclear panic behavior
func CreateDir(path string) {
    // panics on error - not obvious from name
}
```

**Real review comment:** *"nit: this kind of func that panics or exits usually are named with the `Must` prefix"*

---

## Interface Design

### Define Interfaces at Point of Use
Per [Google Go Decisions](https://google.github.io/styleguide/go/decisions#interfaces):

```go
// Good - interface at consumer
func NewProvider(cache JWKSCache) *Provider { ... }

// The interface is defined where consumed, not where implemented
```

**Real review comment:** *"nit: wondering if we could unexport this by applying https://google.github.io/styleguide/go/decisions#interfaces"*

### Accept Interfaces, Return Concrete Types
```go
// Good
func NewService(store Store) *Service { ... }
func (s *Service) Process() *Result { ... }

// Bad - returning interface
func NewService(store Store) ServiceInterface { ... }
```

### Keep Interfaces Small
```go
// Good - focused interface
type Store interface {
    Get(id string) (*User, error)
}

// Bad - kitchen sink
type Store interface {
    Get(id string) (*User, error)
    List() ([]*User, error)
    Create(*User) error
    Update(*User) error
    Delete(id string) error
    Count() int
    // ...
}
```

### Use Interface Assertions
```go
// Good - compile-time interface check
var _ http.Handler = (*MyHandler)(nil)

// In type definition file
type MyHandler struct { ... }
```

**Real review comment:** *"prefer an interface assertion"*

---

## Protobuf and gRPC

### Always Use Getters for Proto Fields
```go
// Good - nil-safe
name := msg.GetName()
config := response.GetConfig()

// Check before use
if msg.GetConfig() != nil {
    // use config
}

// Bad - can panic on nil
name := msg.Name
config := response.Config
```

**Real review comment:** *"Does `onboardingCfg` come from a proto? Could we use Get methods to avoid nil pointers?"*

### Handle Nil Proto Messages
```go
// Good - nil-safe chain
if op.Spec.GetIstio() == nil || len(op.Spec.GetIstio().GetRevisions()) == 0 {
    return
}

// Better - use Get methods
if len(op.Spec.GetIstio().GetRevisions()) == 0 {
    return
}
```

**Real review comment:** *"`if op.Spec.GetIstio() == nil || len(op.Spec.GetIstio().Revisions) == 0 {` -> `if len(op.Spec.GetIstio().GetRevisions()) == 0 {`"*

---

## Nil Safety

### Check Nil Before Dereferencing
```go
// Good
if cp.Spec.TelemetryStore != nil {
    // use TelemetryStore
}

// Bad - potential panic
value := cp.Spec.TelemetryStore.RetentionDays
```

**Real review comment:** *"The function accesses `cp.Spec.TelemetryStore` without checking if it's nil first. This could cause a nil pointer panic"*

### Return nil Instead of Empty Slice When Appropriate
```go
// Good - return nil, callers can range and len() safely
func (r *Repo) List() ([]Item, error) {
    if notFound {
        return nil, nil  // nil slice is fine
    }
    return items, nil
}

// Note: you can range over and len() a nil slice safely
var s []int = nil
for _, v := range s { }  // works
len(s) == 0              // true
```

**Real review comment:** *"There is no need to return an empty list here; just return `nil`. Take into account that you can `range` over a nil slice and also call `len`"*

### Append Handles Nil Slices
```go
// Good - append works on nil
var items []Item
items = append(items, newItem)

// Use when size unknown
if someCondition {
    items = append(items, item)
}
```

---

## Slice and Map Patterns

### Specify Capacity When Known
Per [Uber Guide](https://github.com/uber-go/guide/blob/master/style.md#specifying-slice-capacity):

```go
// Good - pre-allocate
users := make([]User, 0, len(ids))
for _, id := range ids {
    users = append(users, User{ID: id})
}

// Bad - grows dynamically
var users []User
for _, id := range ids {
    users = append(users, User{ID: id})
}
```

**Real review comment:** *"fyi I've seen this https://github.com/uber-go/guide/blob/master/style.md#specifying-slice-capacity applied in several places in the codebase"*

### Use maps.Keys and slices.Collect
```go
// Good - use stdlib helpers (Go 1.21+)
keys := slices.Collect(maps.Keys(myMap))

// Bad - manual iteration
var keys []string
for k := range myMap {
    keys = append(keys, k)
}
```

**Real review comment:** *"use `maps.Keys` instead?"*

### Use strings.Cut for Splitting
```go
// Good
prefix, suffix, found := strings.Cut(s, "/")

// Bad
parts := strings.SplitN(s, "/", 2)
if len(parts) < 2 { ... }
```

---

## Named Returns

### Avoid Named Returns Unless Necessary
Per [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments#named-result-parameters):

```go
// Good - clear without named returns
func process() (Config, error) {
    cfg := Config{}
    if err := load(&cfg); err != nil {
        return Config{}, err
    }
    return cfg, nil
}

// Named returns only when they improve readability
// e.g., multiple returns of same type
func coords() (x, y int) { ... }
```

**Real review comment:** *"I don't think named results help here, as per https://github.com/golang/go/wiki/CodeReviewComments#named-result-parameters"*

---

## Logging

### Use Structured Logging
```go
// Good - structured fields
logger.Info("processing request",
    "user_id", userID,
    "duration_ms", duration.Milliseconds(),
)

// Bad - string formatting
log.Printf("processing request user=%s duration=%v", userID, duration)
```

### Don't Log at Inappropriate Levels
```go
// Bad - too verbose for info level
logger.Info("polling every 5 seconds")  // Runs every 5 seconds!

// Good - use debug for frequent events
logger.Debug("polling", "interval", "5s")
```

**Real review comment:** *"Probably too verbose for `info` level? They will appear every 5 seconds"*

---

## Documentation

### Follow Go Doc Conventions
Per [Go Blog - Godoc](https://blog.golang.org/godoc):

```go
// Good - starts with function name
// Process validates and transforms the input data.
// It returns an error if validation fails.
func Process(data []byte) (*Result, error) { ... }

// Bad - doesn't start with name
// This function validates and transforms data.
func Process(data []byte) (*Result, error) { ... }
```

**Real review comment:** *"Follow the go comment conventions when adding comments to methods"*

### Remove Commented Code
```go
// Bad - leaving commented code
// oldFunction()  // Removed in PR #1234

// Good - just delete it
```

**Real review comment:** *"Remove commented code"*

---

## Common Review Comments

### nit: Prefix for Minor Issues
Use `nit:` prefix for non-blocking suggestions:
- Typos, style preferences
- Minor refactoring opportunities
- Suggestions that are "nice to have"

### References to Style Guides
Common references in reviews:
- [Uber Go Style Guide](https://github.com/uber-go/guide/blob/master/style.md)
- [Effective Go](https://go.dev/doc/effective_go)
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- [Google Go Style Guide](https://google.github.io/styleguide/go/)

---

## Review Checklist

When reviewing Go code, check:

### Error Handling
- [ ] Errors wrapped with context (no "failed to" prefix)
- [ ] Sentinel errors for known conditions
- [ ] No swallowed errors
- [ ] errors.Join for multiple errors

### Code Quality
- [ ] Guard clauses / early returns
- [ ] No deep nesting (max 2-3 levels)
- [ ] Functions under ~40 lines
- [ ] Consistent naming (no Get prefix)

### Testing
- [ ] Uses `require` library
- [ ] Uses require.ErrorIs for sentinel errors
- [ ] Test data in testdata/ folder
- [ ] No tests of mock behavior only

### Thread Safety
- [ ] Shared state protected
- [ ] RWMutex for read-heavy access
- [ ] Pointer receivers with mutexes
- [ ] No sync.Once misuse

### Proto/gRPC
- [ ] Uses Get methods (nil-safe)
- [ ] Nil checks before dereferencing

### Style
- [ ] Capitalizes initialisms (ID, URL, HTTP)
- [ ] No underscore prefixes
- [ ] Must prefix for panicking functions
- [ ] Interfaces at point of use

---

**Source:** 4,100+ PR review comments from tetrateio/tetrate (2020-2025)
