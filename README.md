# heredoc

A collection of `Text`-based utilities for manipulating (conceptual) [Here
documents][heredocs]. So far, just [dedent](#todo).

[heredocs]: https://en.wikipedia.org/wiki/Here_document

## Example

### `dedent`

```hs
import Data.Text (Text)
import Data.Text.Heredoc
import qualified Data.Text.IO as T
import Text.Shakespeare.Text (st)

main :: IO ()
main = do
  let
    mydoc :: Text
    mydoc = [st|
      Here's a line.

        And another.

      Thanks.
    |]

  T.putStrLn $ dedent mydoc
```

```console
% stack exec example
Here's a line.

  And another.

Thanks
```

---

[CHANGELOG](./CHANGELOG.md) | [LICENSE](./LICENSE)
